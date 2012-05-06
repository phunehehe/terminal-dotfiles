Dotfiles for terminal programs that I will use to deploy to all servers I work with.

Copy and paste for the lazy:

    cat > rcsync.sh <<RCSYNC
    #!/bin/sh
    rm -rf temp-dotfiles
    mkdir -p temp-dotfiles
    cd temp-dotfiles
    wget https://github.com/phunehehe/terminal-dotfiles/raw/master/install.sh --no-check-certificate
    chmod +x install.sh
    ./install.sh
    RCSYNC

    chmod +x rcsync.sh
    ./rcsync.sh

Those commands will create a script named `rcsync.sh` in the current directory. The script will download and setup config files and any necessary plugins etc under `$HOME`. The script can be used again and again to sync the config. Existing dotfiles will be backed up, just in case.

See my blog post [Keeping dotfiles in sync using GitHub](http://phunehehe.is-great.org/2011/keeping-dotfiles-in-sync-using-github/) for a discussion on how to keep the same configurations on many machines.
