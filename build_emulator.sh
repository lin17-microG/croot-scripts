#!/bin/bash

# Own values
export CCACHE_DIR=~/.ccache17
export OUT_DIR_COMMON_BASE=~/out-android

# Use pre-defined build script
source z_patches/build_device.sh x86 $1 $2

