#!/usr/bin/env bash

BUILD_ROOT="$PWD"

QSSI_DIR="${BUILD_ROOT}/qssi"
VENDOR_DIR="${BUILD_ROOT}/vendor"
LE_DIR="${BUILD_ROOT}/le"
KERNEL_PLATFORM="${VENDOR_DIR}/kernel_platform"

function build_target {
    cd "$VENDOR_DIR"
    source build/envsetup.sh
    lunch taro-userdebug
    RECOMPILE_KERNEL=1 kernel_platform/build/android/prepare_vendor.sh waipio gki
    ./build.sh dist --target_only -j "$(nproc --all)"
}

function build_qssi {
    cd "$QSSI_DIR"
    source build/envsetup.sh
    lunch qssi-userdebug
    ./build.sh dist --qssi_only -j "$(nproc --all)"
}

function build_super {
    cd "$VENDOR_DIR"

    python vendor/qcom/opensource/core-utils/build/build_image_standalone.py \
        --image super \
        --qssi_build_path "$QSSI_DIR" \
        --target_build_path "$VENDOR_DIR" \
        --merged_build_path "$VENDOR_DIR" \
        --target_lunch taro \
        --no_tmp \
        --output_ota \
        --skip_qiifa
}

function build_kernel {
    cd "$VENDOR_DIR"
    bash kernel_platform/qcom/proprietary/prebuilt_HY11/vendorsetup.sh
    cd "$KERNEL_PLATFORM"
    BUILD_CONFIG=./common/build.config.msm.waipio ./build/all-variants.sh "./build/build.sh" |& tee kernel_makelog_$(date +%Y%m%d_%H%M%S).txt
    cd "$VENDOR_DIR"
    cp -r "$KERNEL_PLATFORM"/out/* "$VENDOR_DIR"/out/
}

function build_le {
    cd "$KERNEL_PLATFORM" && BUILD_CONFIG=msm-kernel/build.config.msm.waipio.tuivm VARIANT=debug_defconfig ./build/build.sh
    mkdir -p "$LE_DIR"/src/kernel-5.10/
    cp -rp "$VENDOR_DIR"/kernel_platform "$LE_DIR"/src/kernel-5.10/
    cp -rp "$VENDOR_DIR"/kernel_platform/out/ "$LE_DIR"/src/kernel-5.10/
    cd "$LE_DIR"
    export SHELL=/bin/bash
    export MACHINE=genericarmv8
    export DISTRO=qti-distro-base-debug
    source poky/qti-conf/set_bb_env.sh
    bitbake qti-vm-image
}

build_qssi
build_kernel
build_target
build_super
build_le
