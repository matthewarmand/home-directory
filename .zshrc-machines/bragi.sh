#!/usr/bin/zsh

# Add to Path packages managed by Cargo (Rust)
export PATH=$PATH:/home/matt/.cargo/bin

# for realTimeAudioConfigQuickScan
export SOUND_CARD_IRQ=38

alias pavucontrol=pavucontrol-qt

# Specify plugins for zsh
plugins=(git)
