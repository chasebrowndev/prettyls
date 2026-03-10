# prettyls

A pretty, human-friendly replacement for `ls` — with icons, colors, human-readable sizes, and a clean tabular layout.

```
 ~/projects/prettyls
| permissions | owner            | size         | date       | name
|-------------|------------------|--------------|------------|--------------------
| drwxr-xr-x  | chase            |        4096 B | 03/10/2026 |  src
| drwxr-xr-x  | chase            |        4096 B | 03/10/2026 |  tests
| -rw-r--r--  | chase            |        1.23 KB | 03/09/2026 |  README.md
| -rwxr-xr-x  | chase            |        3.45 KB | 03/10/2026 |  prettyls.sh
| -rw-r--r--  | chase            |       12.50 KB | 03/08/2026 |  archive.tar.gz
  2 dir(s), 3 file(s)
```

> **Note:** Icons require a [Nerd Font](https://www.nerdfonts.com/). The installer can set one up for you automatically (see below).

---

## Features

- Color-coded output by file type (directories, executables, archives, images)
- Nerd Font icons for at-a-glance file identification
- Human-readable file sizes (B / KB / MB / GB)
- Directories listed before files
- Hidden file toggle (`-a`)
- Recursive listing (`-R`)

---

## Installation

#
# AT THE MOMENT HERE (Github) AND Codeberg ARE THE ONLY PLACES YOU CAN DOWNLOAD THIS. AUR WILL BE ADDED SOON. THE FOLLOWING IS PLACEHOLDER TEXT:
#
### AUR (Arch Linux)

```bash
# Using yay
yay -S prettyls

# Using paru
paru -S prettyls
```

The installer will automatically:
- Install the JetBrainsMono Nerd Font to `~/.local/share/fonts/NerdFonts/`
- Add `alias ls='prettyls'` to your `~/.bashrc` and/or `~/.zshrc`

After installing, restart your terminal and set your terminal font to **JetBrainsMono Nerd Font**.

### Manual

```bash
git clone https://github.com/chasebrown/prettyls.git
cd prettyls
chmod +x prettyls.sh
sudo cp prettyls.sh /usr/local/bin/prettyls
```

Then optionally add to your shell config:

```bash
alias ls='prettyls'
```

---

## Usage

```
prettyls [OPTIONS] [FILE/DIR...]

Options:
  -a, --all          Show hidden files (dotfiles)
  -R, --recursive    List directories recursively
  -h, --help         Show this help message
  -v, --version      Show version
```

### Examples

```bash
prettyls                    # list current directory
prettyls -a                 # include dotfiles
prettyls -R ~/projects      # recursive listing
prettyls file.txt           # inspect a single file
```

---

## Nerd Font Setup

Icons will appear as boxes or question marks without a Nerd Font. The AUR installer handles this automatically. For manual installs:

1. Download a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) (JetBrainsMono recommended)
2. Install it to `~/.local/share/fonts/` and run `fc-cache -f`
3. Set your terminal emulator's font to the Nerd Font variant

---

## License

MIT — see [LICENSE.txt](LICENSE.txt)

---

## Mirrors

- GitHub: https://github.com/chasebrowndev/prettyls
- Codeberg: https://codeberg.org/chasebrowndev/prettyls
