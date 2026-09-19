#!/bin/bash

# Fix the broken icons in Tsukimi (GTK 4.22 + the Yaru icon theme).
#
# Two causes, two steps:
#  1. Tsukimi's own SVG icons lack width/height (one has a viewBox that does not
#     start at 0,0), which GTK 4.22 refuses to render. They are downloaded from the
#     Tsukimi source and normalized.
#  2. Yaru does not inherit from Adwaita, so many standard symbolic icons are
#     missing. The Adwaita ones are copied in as a fallback (hicolor is the last
#     theme in the chain, so nothing that Yaru has is overridden).
#
# Usage: tsukimi-icons.sh          (env ICON_DEST overrides ~/.local/share/icons/hicolor)

set -euo pipefail

DEST=${ICON_DEST:-$HOME/.local/share/icons/hicolor}
VERSION=${TSUKIMI_VERSION:-$(pacman -Q tsukimi 2>/dev/null | awk '{print $2}' | sed 's/-[0-9]*$//')}
[[ -n $VERSION ]] || {
  echo "Tsukimi nie je nainštalovaný (alebo nastav TSUKIMI_VERSION)." >&2
  exit 1
}

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

echo "Sťahujem zdroje Tsukimi v$VERSION..."
curl -fsSL "https://github.com/tsukinaha/tsukimi/archive/refs/tags/v$VERSION.tar.gz" | tar xz -C "$WORK" --strip-components=1

mkdir -p "$DEST/scalable/actions"

python3 - "$WORK/crates/tsukimi/resources/icons/scalable/actions" "$DEST/scalable/actions" <<'PY'
import re, sys, pathlib, xml.etree.ElementTree as ET
src, dst = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
SVG = 'http://www.w3.org/2000/svg'
ET.register_namespace('', SVG)
ET.register_namespace('inkscape', 'http://www.inkscape.org/namespaces/inkscape')
ET.register_namespace('sodipodi', 'http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd')
fmt = lambda v: '%g' % v
count = 0
for f in sorted(src.glob('*.svg')):
    root = ET.fromstring(f.read_text(encoding='utf8'))
    vb, w, h = root.get('viewBox'), root.get('width'), root.get('height')
    if vb:
        x, y, vw, vh = [float(v) for v in vb.replace(',', ' ').split()]
    else:
        num = lambda s: float(re.match(r'[\d.]+', s).group(0))
        x = y = 0
        vw, vh = num(w or '16'), num(h or '16')
    if not w or not h or re.search(r'[^\d.]', (w or '') + (h or '')):
        root.set('width', fmt(vw)); root.set('height', fmt(vh))
    if x != 0 or y != 0:
        g = ET.Element('{%s}g' % SVG, {'transform': 'translate(%s %s)' % (fmt(-x), fmt(-y))})
        for child in list(root):
            if child.tag.split('}')[-1] in ('defs', 'metadata', 'namedview', 'title', 'desc'):
                continue
            root.remove(child); g.append(child)
        root.append(g)
    if x != 0 or y != 0 or not vb:
        root.set('viewBox', '0 0 %s %s' % (fmt(vw), fmt(vh)))
    for el in root.iter():
        el.attrib.pop('paint-order', None)
        st = el.get('style')
        if st and 'paint-order' in st:
            el.set('style', re.sub(r'paint-order:[^;]*;?', '', st))
    (dst / f.name).write_text(ET.tostring(root, encoding='unicode'), encoding='utf8')
    count += 1
print('Opravených vlastných ikon Tsukimi: %d' % count)
PY

# Adwaita fallback for everything Yaru lacks (hicolor is searched last).
copied=0
while read -r svg; do
  ctx=$(basename "$(dirname "$svg")")
  case $ctx in ui | symbolic | legacy) ctx=actions ;; esac
  target="$DEST/scalable/$ctx/$(basename "$svg")"
  if [[ ! -e $target ]]; then
    mkdir -p "$(dirname "$target")"
    cp "$svg" "$target"
    copied=$((copied + 1))
  fi
done < <(find /usr/share/icons/Adwaita/symbolic -name '*-symbolic.svg' 2>/dev/null)
echo "Doplnených ikon z témy Adwaita: $copied"

# one that Adwaita 50 does not have: the player's "sidebar right" button
[[ -e $DEST/scalable/actions/dock-right-symbolic.svg ]] ||
  cp /usr/share/icons/Adwaita/symbolic/actions/sidebar-show-right-symbolic.svg "$DEST/scalable/actions/dock-right-symbolic.svg" 2>/dev/null || true

command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -f -t "$DEST" >/dev/null 2>&1 || true
echo "Hotovo. Reštartuj Tsukimi."
