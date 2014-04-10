

alias gem=gem1.9.3
alias ruby=ruby1.9.3

export GEM_HOME=~/.gem
export GEM_PATH=$GEM_HOME/bin
export PATH=$GEM_PATH:$PATH

gem install rex --no-rdoc --no-ri
gem install racc --no-rdoc --no-ri
