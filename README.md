# Qualcomm Products Board Support Package (BSP) HLOS Sync scripts

## Why was these scripts created?
1. These scripts was created to automate the process of syncing the Qualcomm Products Board Support Package (BSP) sources.
2. Qualcomm had released the "Release Note" for every Software Product (SP), but sometimes it's hard to find the correct sources or hard to use for the SP.
3. These scripts helps to sync the Qualcomm Products BSP sources easily.

## How to use?
1. Clone this repository
2. Run the scripts with the following command

#### Sync all Sources (QSSI Open Source parts & Vendor Open Source parts & Linux Embedded (LE) Open Source parts)
```bash
$ bash setup.sh && bash sync.sh
```

#### Sync Qualcomm private code (QSSI & Vendor Closed Source parts)
###### Note: You need to have access to the Qualcomm ChipCode website to download the private code.
- Download the Qualcomm private code from the Qualcomm ChipCode Website or use Git to clone the private code repository.
- For example, the QCM6490 BSP private code is located at `https://chipcode.qti.qualcomm.com/qualcomm/qcm6490-la-3-0_ap_standard_oem`
- So clone the private code repository using the following command
```bash
$ git clone -b r00082.2 --depth 1 https://qpm-git.qualcomm.com/home2/git/qualcomm/qcm6490-la-3-0_ap_standard_oem.git
```
- Notes: 
  1. The `r00082.2` is the tag name of the private code. You can use the latest tag name.
  2. The `--depth 1` is used to clone the latest commit only. You can remove it to clone the full repository.
  3. Don't place the private code directory inside the OpenSources repository directory. Keep it separate.
- Copy the private code to the `vendor/qcom/proprietary` directory.

```bash
/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/LA.QSSI.15.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"

/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/LA.QSSI.12.0.r1/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/DISPLAY.LA.2.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/VIDEO.LA.2.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/CAMERA.LA.2.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/LA.VENDOR.1.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"


/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/KERNEL.PLATFORM.1.0/kernel_platform/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"



/bin/cp -rf ~/BSP/SM84xx_BSP_Sync/snapdragon-premium-high-2021-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00010.0/LE.UM.5.3.1/apps_proc/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
```

#### Build/Compile taro HLOS
```bash
$ bash build.sh
```

## License
These scripts is licensed under the GPL-3.0 License. See the [LICENSE](LICENSE) file for details.

## Credits
- [Qualcomm Technologies, Inc.](https://www.qualcomm.com/)
- [Qualcomm Chipcode](https://chipcode.qti.qualcomm.com)
- [CodeLinaro](https://git.codelinaro.org/)
- [Jyotiraditya](https://github.com/imjyotiraditya)
- [EdwardWu](https://github.com/bluehomewu)
- [QRD-Development](https://github.com/QRD-Development)
