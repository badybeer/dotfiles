# dotfiles

Záloha môjho nastavenia Omarchy (Hyprland): skripty, klávesové skratky, lišta a spúšťače.

## Čo je v zálohe

| Vec | Kde | Skratka |
|---|---|---|
| Chat hub (Telegram, Discord, Messenger, Instagram, WhatsApp, Teams ako záložky na workspace 10) | `chat-hub`, `chat-hub-help` | `SUPER+M`, `SUPER+ALT+M` |
| Emby: klient Tsukimi a sťahovanie offline (`emby-dl`) | `tsukimi-open`, `emby-dl`, `emby-dl-window` | `SUPER+SHIFT+V`, `SUPER+ALT+V` |
| Kino režim (bez zámku, notifikácií a lišty) | `kino` | `SUPER+SHIFT+K` |
| Vzdialená plocha: VPN + Remmina | `remote`, `remote-window` | `SUPER+SHIFT+R` |
| Zálohovanie samotné | `dotfiles-sync` | |
| Konfigurácia Hyprland, lišta Omarchy, webapps | `~/.config/hypr`, `~/.config/omarchy`, `.desktop` súbory | |

Presný zoznam ciest je v `manifest.txt`.

## Použitie

```bash
dotfiles-sync            # záloha: skopíruje živé súbory, skontroluje tajomstvá, commit + push
dotfiles-sync status     # čo sa od poslednej zálohy zmenilo
dotfiles-sync restore    # obnova z repozitára do $HOME (odlišné súbory sa uložia ako *.bak-<čas>)
```

Záloha sa **zastaví**, ak nájde v súboroch niečo, čo vyzerá ako heslo, kľúč alebo token.

## Obnova na novom systéme

1. `git clone <tento repozitár> ~/dotfiles`
2. `~/dotfiles/home/.local/bin/dotfiles-sync restore`
3. `hyprctl reload` a `omarchy restart shell`
4. Balíky z AUR, ktoré som mal: pozri `packages-aur.txt` (`yay -S $(cat packages-aur.txt)`), hlavne `tsukimi`.
5. Ikony v Tsukimi: `restore/tsukimi-icons.sh` (opravuje rozbité ikony s GTK 4.22 a témou Yaru).
6. Webapps (WhatsApp, Discord už dodáva Omarchy): `Messenger`, `Instagram` a `Teams` sú v zálohe ako `.desktop`
   súbory; ak chýbajú ikony, spusti `omarchy webapp install` znova.

## Čo v zálohe **nie je** (zámerne)

- **Heslá a prihlásenia**: `emby-dl` si ukladá prihlásenie do systémovej kľúčenky. Na novom systéme spusti
  `emby-dl` a ulož ho znova.
- **Profily Remmina** (`~/.local/share/remmina`) a **konfigurácia WireGuard** (`/etc/wireguard`): obsahujú
  adresy serverov a kľúče.
- Stiahnuté filmy (`~/Videos/Emby`), cache a build adresáre.

## Poznámky

- Sudo pravidlo pre `wg-quick up/down wg0` (bez hesla) je v `/etc/sudoers.d`, nie v zálohe. Skript `remote` a
  ikonka VPN v lište ho potrebujú.
- `emby-dl` si adresu Emby servera pamätá v `~/.config/emby-dl/server` (pri prvom spustení sa opýta). Tento
  súbor **nie je v zálohe**, aby adresa servera nebola na verejnom GitHube. Premenná `EMBY_SERVER` ju prepíše.

## Súkromie (repozitár je verejný)

`dotfiles-sync` pred každým commitom kontroluje a pri nájdení **zastaví zálohu**:

- kľúče, tokeny a heslá,
- e-mailové adresy a verejné IP adresy,
- osobné údaje zo zoznamu `~/.config/dotfiles-sync/never-publish.txt` (mimo repozitára) a adresy serverov
  z lokálnych profilov Remmina a z nastavenia `emby-dl`,
- commity s iným e-mailom ako GitHub no-reply.
