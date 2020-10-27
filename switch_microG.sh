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
#    BRANCH2="lineage-16.0"
#    BRANCH3="lin-16.0-microG"
#    BRANCH4="lin-16.0-microG"
    PATCHV="S"
    ;;
  default) 
    BRANCH1="lineage-17.1"
#    BRANCH2="lineage-16.0"
#    BRANCH3="lineage-16.0"
#    BRANCH4="lineage-16.0"
    PATCHV="S"
    ;;
  reference) 
    BRANCH1="lineage-17.1"
#    BRANCH2="lineage-16.0"
#    BRANCH3="lineage-16.0"
#    BRANCH4="changelog"
    PATCHV="N"
    ;;
  *) 
    echo "usage: switch_microg.sh default | microG | reference"
    echo "-"
    echo "  default   - LineageOS 17.1"
    echo "  microG    - hardened microG build"
    echo "  reference - 100% LineageOS 17.1 (no patches - for 'repo sync')"
    exit
    ;;   
esac

switch_zpatch $BRANCH1 R

switch_branches $BRANCH1 art
#switch_branches $BRANCH1 build/make
#switch_branches $BRANCH2 external/selinux
#switch_branches $BRANCH2 frameworks/av
switch_branches $BRANCH1 frameworks/base
#switch_branches $BRANCH1 frameworks/native
#switch_branches $BRANCH2 frameworks/opt/net/wifi
#switch_branches $BRANCH2 frameworks/opt/telephony
#switch_branches $BRANCH1 lineage-sdk
switch_branches $BRANCH1 libcore
#switch_branches $BRANCH3 packages/apps/Jelly
switch_branches $BRANCH1 packages/apps/LineageParts
switch_branches $BRANCH3 packages/apps/Nfc
switch_branches $BRANCH1 packages/apps/Settings
#switch_branches $BRANCH3 packages/services/Telecomm
#switch_branches $BRANCH2 packages/services/Telephony
#switch_branches $BRANCH2 system/bt
switch_branches $BRANCH1 system/core
#switch_branches $BRANCH2 system/netd
#switch_branches $BRANCH1 system/sepolicy
#switch_branches $BRANCH2 system/vold
switch_branches $BRANCH1 vendor/lineage
#switch_branches $BRANCH2 vendor/qcom/opensource/cryptfs_hw
switch_branches $BRANCH1 .repo/local_manifests
#switch_branches $BRANCH4 OTA

switch_zpatch $BRANCH1 $PATCHV

