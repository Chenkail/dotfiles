#! /bin/zsh

# Home directory
cd ~

# Repository folder for zsh config files
DOTFILES='https://raw.githubusercontent.com/Chenkail/dotfiles/main/zsh'

# Install prezto
if [ ! -d ".zprezto" ]; then
  echo "Installing prezto:"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  echo
fi

# zplug
if [ ! -d ".zplug" ]; then
  echo "Installing zplug:"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Config files
echo "Copying config files:"
curl ${DOTFILES}/.zpretzorc > zpretzorc.new
curl ${DOTFILES}/.zshrc > zshrc.new

mv zpretzorc.new "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpretzorc
mv zshrc.new "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc
echo

# Set up thefuck
read name\?"Configure thefuck? "
if [[ $REPLY =~ ^[Yy]$ ]]
then
  fuck
  fuck
fi

# Run p10k setup
read name\?"Configure p10k? "
if [[ $REPLY =~ ^[Yy]$ ]]
then
  p10k configure
fi

# Reload zsh to save changes
echo "Reloading zsh!"
exec zsh
