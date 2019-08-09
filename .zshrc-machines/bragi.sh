#!/usr/bin/zsh

export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME

# Add to Path packages managed by Cargo (Rust)
export PATH=$PATH:/home/matt/.cargo/bin

# for realTimeAudioConfigQuickScan
export SOUND_CARD_IRQ=38

alias pavucontrol=pavucontrol-qt

# Specify plugins for zsh
plugins=(git virtualenv)
