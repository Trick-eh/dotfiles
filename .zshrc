 eval "$(starship init zsh)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="/home/trickk/.config/zsh/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::gradle
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q
# cmp opts
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':completion:*:descriptions' format '[%d]'
### ketbindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

### history settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### FUNCTIONS

ex (){
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      unrar x $1      ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *.7z)       7z x $1         ;;
            *.deb)      ar x $1         ;;
            *.tar.xz)   tar xf $1       ;;
            *.tar.zst)  unzstd $1       ;;
            *)          echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## Note creation

new_weekly_note (){
    weekly_name=$(date +%Y-%W)
    weekly_file=$HOME/second-brain/periodic-notes/weekly/$weekly_name.md
    touch $weekly_file
    
    echo "# $weekly_name" > $weekly_file
    echo "" >> $weekly_file
    echo "## daily notes of this week:" >> $weekly_file
}

new_daily_note (){
    daily_name=$(date +%Y-%m-%d)
    daily_file=$HOME/second-brain/periodic-notes/daily/$daily_name.md
    weekly_name=$(date +%Y-%W)
    weekly_file=$HOME/second-brain/periodic-notes/weekly/$weekly_name.md
    touch $daily_file

    if [ ! -f $weekly_file ]; then
        new_weekly_note
    fi

    echo "# $daily_name" > $daily_file
    echo "> this week: [[periodic-notes/weekly/$weekly_name.md|$weekly_name]]" >> $daily_file
    echo "" >> $daily_file
    echo "## Notes made today" >> $daily_file
    echo "- [[periodic-notes/daily/$daily_name.md|$daily_name]]" >> $weekly_file
}

daily (){
    file_name=$(date +%Y-%m-%d)
    cd $HOME/second-brain/
    if [ ! -f periodic-notes/daily/$file_name.md ]; then
        new_daily_note
    fi
    nvim periodic-notes/daily/$file_name.md
}

weekly (){
    # checks if the weekly note, which should be titled as %Y-%W, exists in ~/second-brain/periodic-notes/weekly/, if it exists, it will open it in nvim, if not, it will create it and open it
    file_name=$(date +%Y-%W)
    cd $HOME/second-brain/
    if [ ! -f periodic-notes/weekly/$file_name.md ]; then
        new_weekly_note
    fi
    nvim periodic-notes/weekly/$file_name.md
}

newnote (){
    file_name=$1
    if [[ $file_name == "" ]]; then
        echo "the first argument must be a non empty string"
        return 
    fi
    cd $HOME/second-brain/
    if [ -f 0-inbox/$file_name.md ]; then
        echo "a note with such title already exists"
        return
    fi

    touch 0-inbox/$file_name.md
    echo "# $file_name" > 0-inbox/$file_name.md
    
    daily_note=$(date +%Y-%m-%d)
    if [ ! -f periodic-notes/daily/$daily_note.md ]; then
        new_daily_note
    fi

    echo "- [[0-inbox/$file_name.md|$file_name]]" >> periodic-notes/daily/$daily_note.md
    echo "> written on [[periodic-notes/daily/$daily_note.md|$daily_note]]" >> 0-inbox/$file_name.md

    nvim 0-inbox/$file_name.md
}
### ALIASES

# package management
alias pacsyu="sudo pacman -Syyu"                    # update standard pkgs only
alias yaysua="yay -Sua --noconfirm"                 # update AUR pkgs only
alias yaysyu="yay -Syu --noconfirm"                 # update all pkgs
alias unlock="sudo rm /var/lib/pacman/db.lck"       # remove pacman lock
alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"    # remove orphaned pkgs

# mirrorlists
alias mirror="sudo reflector -f 100 -l 100 --number 10 --threads 3 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# ls is now exa
alias ls="exa -al --color=always --group-directories-first"     # better ls
alias la="exa -a --color=always --group-directories-first"      # all files and dirs
alias ll="exa -l --color=always --group-directories-first"      # long format
alias lt="exa -aT --color=always --group-directories-first"     # tree listing
alias l.="exa -a | egrep '^\.'"

# cat is now bat
alias cat="bat"

# grep grepping 
alias grep="grep --color=auto"
alias egrep="grep -E --color=auto"
alias fgrep="grep -F --color=auto"

# add flags
alias cp="cp -i"
alias df="df -h"
alias free="free -h"

# git
alias addall="git add ."
alias branch="git branch"
alias checkout="git checkout"
alias commit="git commit -m"
alias fetch="git fetch"
alias pull="git pull origin"
alias push="git push origin"
alias status="git status"
alias tag="git tag"
alias newtag="git tag -a"

# scripts
alias programlist="bash ~/.scripts/programs.sh"

# utilities
alias wifi="nmtui"
alias bluetooth="bluetuith"
alias rm="rmtrash"
alias sd="shutdown -h now"

# text to speech
alias tts-en="espeak-ng -v"
alias tts-es="espeak-ng -ves"

# QR-related
alias scanqr='zbarimg'
alias scanqr-live='zbarcam'

# idk how to label this
alias harlequin='harlequin --theme catppuccin-mocha'
alias fastread='speedread'

# rickrolling
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

# TODO: see why these don't work
alias tn="tmux new-session -s"
alias tl="tmux list-sessions"
alias ta="tmux attach-session"

# custom cd's
alias dot="cd ~/dotfiles/"
alias brain="cd ~/second-brain/"

### EXPORTS
set -o emacs

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'
export EDITOR="nvim"
export SYSTEM_EDITOR=$EDITOR
export VISUAL="/usr/bin/zathura"
export BROWSER="/usr/bin/zen-browser"
export TERMINAL="ghostty"
export GPG_TTY=$(tty)
export THEME="miasma"
export WALLPAPER="night-city-dark.png"
export PATH="$PATH:$HOME/.cargo/bin"
export MANPAGER="nvim +Man!"
# export GITHUB_TOKEN=$(pass show github/tokens/personal)
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(atuin gen-completions --shell zsh)"
