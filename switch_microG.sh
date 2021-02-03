#!/bin/bash

switch_branches() {
  TOPDIR=$PWD
  cd $2
  echo "-"
  echo "$PWD"
  git checkout $1 && git pull github $1
  cd $TOPDIR
}

switch_zpatch() {
  TOPDIR=$PWD
  cd z_patches
  echo "-"
  echo "$PWD"
  case "$2" in 
    R) ./patches_reverse.sh
       git checkout $1
       ;;
    S) ./patches_apply.sh  
       ;;
  esac
  cd $TOPDIR
}

case "$1" in
  microG)
    BRANCH1="lin-17.1-microG"
    BRANCH2="lineage-17.1"
    BRANCH3="lin-17.1-microG"
    BRANCH4="lin-17.1-microG"
    PATCHV="S"
    ;;
  hmalloc)
    BRANCH1="lin-17.1-microG"
    BRANCH2="lin-17.1-hmalloc"
    BRANCH3="lin-17.1-hmalloc"
    BRANCH4="lin-17.1-microG"
    PATCHV="S"
    ;;
  default)
    BRANCH1="lineage-17.1"
    BRANCH2="lineage-17.1"
    BRANCH3="lineage-17.1"
    BRANCH4="lineage-17.1"
    PATCHV="S"
    ;;
  reference)
    BRANCH1="lineage-17.1"
    BRANCH2="lineage-17.1"
    BRANCH3="lineage-17.1"
    BRANCH4="changelog"
    PATCHV="N"
    ;;
  *) 
    echo "usage: switch_microg.sh default | microG | reference"
    echo "-"
    echo "  default   - LineageOS 17.1"
    echo "  microG    - hardened microG build"
    echo "  hmalloc   - hardened microG build with hardened-malloc"
    echo "  reference - 100% LineageOS 17.1 (no patches - for 'repo sync')"
    exit
    ;;   
esac

switch_zpatch $BRANCH3 R

switch_branches $BRANCH1 art
switch_branches $BRANCH2 bionic
switch_branches $BRANCH1 frameworks/base
switch_branches $BRANCH3 frameworks/native
switch_branches $BRANCH1 libcore
switch_branches $BRANCH1 packages/apps/LineageParts
switch_branches $BRANCH1 packages/apps/Nfc
switch_branches $BRANCH1 packages/apps/Settings
switch_branches $BRANCH3 system/core
switch_branches $BRANCH1 system/sepolicy
switch_branches $BRANCH1 vendor/lineage
switch_branches $BRANCH1 .repo/local_manifests
#switch_branches $BRANCH4 OTA

switch_zpatch $BRANCH1 $PATCHV

