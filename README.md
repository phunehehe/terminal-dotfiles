This is intended for my personal use. If you want to use it, at least fork the
repo and change the identity in `_gitconfig`.


Copy and paste for the lazy me:

```bash
git clone --recursive git://github.com/phunehehe/terminal-dotfiles.git
./terminal-dotfiles/install.sh
rm -r .*.terminal-dotfiles-*
```

Existing dotfiles will be backed up, just in case, but the last line delete the
backups :D


To update an existing installation:

```bash
./terminal-dotfiles/update.sh
```
