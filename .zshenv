#!/bin/sh

# Default editor
export EDITOR='/usr/bin/nvim'
export VEDITOR='/usr/bin/code'

#Language in date
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Java version can be changed between 8, 11 and 22
export JAVA_VERSION=11
export JAVA_HOME=/usr/lib/jvm/java-"$JAVA_VERSION"-openjdk
export PATH=$JAVA_HOME/bin:$PATH

export ROCKU=/usr/share/wordlists/rockyou.txt

export CACHE_DIR=$HOME/.cache/
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
