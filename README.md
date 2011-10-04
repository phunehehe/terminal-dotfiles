Dotfiles for terminal programs that I will use to deploy to all servers I work with.

Usage:

    mkdir temp-dotfiles && cd temp-dotfiles
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/install.sh --no-check-certificate
    chmod +x install.sh
    ./install.sh

The script will download and setup config files and any necessary plugins etc under your `$HOME`. Your existing dotfiles will be backed up, just in case you need them.

See my blog post [Keeping dotfiles in sync using GitHub](http://phunehehe.isgreat.org/2011/keeping-dotfiles-in-sync-using-github/) for a discussion on how to keep the same configurations on many machines.