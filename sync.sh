#!/usr/bin/env bash

BUILD_ROOT="$PWD"
QSSI_ROOT="${BUILD_ROOT}/qssi"
VENDOR_ROOT="${BUILD_ROOT}/vendor"
LE_ROOT="${BUILD_ROOT}/le"

function sync_repo {
    mkdir -p "$1" && cd "$1"
    echo "[+] Changed directory to $1."

    if repo init --depth=1 -q -u https://github.com/QRD-Development/SM84xx_BSP_Sync.git -b LA.VENDOR.1.0.r1-27300-WAIPIO.QSSI15.0-1 -m "$2"; then
        echo "[+] Repo initialized successfully."
    else
        echo "[-] Error: Failed to initialize repo."
        exit 1
    fi

    echo "[+] Starting repo sync..."
    if schedtool -B -e ionice -n 0 repo sync -q -c --force-sync --optimized-fetch --no-tags --retry-fetches=5 -j"$(nproc --all)"; then
        echo "[+] Repo synced successfully."
    else
        echo "[-] Error: Failed to sync repo."
        exit 1
    fi
}

sync_repo "$QSSI_ROOT" "qssi.xml"
sync_repo "$VENDOR_ROOT" "target.xml"
sync_repo "$LE_ROOT" "le.xml"

cd "$BUILD_ROOT"
echo "[+] Successfully returned to the build root."
