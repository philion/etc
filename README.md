# etc

My shell profile management system.

    git clone git@github.com:philion/etc.git; etc/philstrap/initialize
        

## Lean, Fast & Portable
    
From a FaceBook post:

> I've been copying around a .bashrc for damn near 25 years. I remember adding $JAVA_HOME to it 21 years ago. The most recent innovation was putting it in Dropbox, so it was synced across systems. I haven't used Dropbox in 2 years.
> Any recommendations about current *nix CLI wonders and secure, centralized profile management? (Or is a well-curated bash_completion.d/ and Dropbox state of the art?)
> Note: lean, fast and portable is the name of the game. I don't want to play Doom as part of git commit.


## Features

### `etc/philstrap/dotfiles`

Any file named `dot.something` will be linked to `~/.something`. Unless something is in the way, skipped for now.

### `etc/philstrap/bin`

All files will linked into `~/bin/...`. Unless something is in the way, skipped for now.
