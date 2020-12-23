#! /bin/zsh

# Home directory
cd ~

# Repository folder for zsh config files
DOTFILES='https://raw.githubusercontent.com/Chenkail/dotfiles/main/zsh'

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh


# Config files
curl ${DOTFILES}/.zpretzorc > zpretzorc.new
curl ${DOTFILES}/.zshrc > zshrc.new

mv zpretzorc.new "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpretzorc
mv zshrc.new "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc

# Set up thefuck
read name\?"Configure thefuck? "
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  fuck
  fuck
fi

# Run p10k setup
read name\?"Configure p10k? "
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  p10k configure
fi

# Reload zsh
exec zsh
