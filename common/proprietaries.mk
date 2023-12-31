PROPRIETARY_BOARD := sharkl3
PRODUCT_PACKAGES :=              \
    libomx_hevcdec_hw_sprd       \
    libomx_hevcenc_hw_sprd       \
    libomx_m4vh263dec_sw_sprd    \
    libomx_m4vh263enc_sw_sprd    \
    libomx_m4vh263dec_hw_sprd    \
    libomx_avcdec_sw_sprd        \
    libomx_avcdec_vt_sprd        \
    libomx_avcdec_hw_sprd        \
    libomx_avcenc_hw_sprd        \
    libomx_vpxdec_hw_sprd        \
    libomx_vpxenc_hw_sprd        \
    libomx_vp9dec_hw_sprd        \
    libomx_av1dec_sw_sprd        \
    libdav1d                     \
    libomx_mp3dec_sprd           \
    libomx_mp3enc_sprd           \
    libjpeg_hw_sprd              \
    libjpegenc_sw_sprd           \
    thermald                     \
    cpu_loading                  \
    cpu_hotplug                  \
    cpu_trans_table              \
    dvfs_table                   \
    lit_cpu_freq                 \
    fix_cpu_freq                 \
    fix_gpu_freq                 \
    gpu_loading                  \
    gpu_trans_table              \
    ddr_bm                       \
    ddr_loading                  \
    ddr_trans_table              \
    fix_ddr_freq                 \
    bright                       \
    interrupt                    \
    tops                         \
    power_ctrl                   \
    power_hint                   \
    loading                      \
    paras

# add for volte
ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), true)
PRODUCT_PACKAGES += \
    VceDaemon \
    libvideo_call_engine_jni \
    libvolte_video_service_jni \
    ims_bridged \
    libnl \
    libimsbrd \
    libavatar \
    libzmf \
    libCamdrv24 \
    libmme_jrtc
endif

# Enable VOWIFI functions start
ifeq ($(strip $(VOWIFI_SERVICE_ENABLE)), true)

# vowifi source code module
PRODUCT_PACKAGES += \
    ims \
    SprdVoWifiService \
    ImsCM \
    operator_config.xml

# ims bridge daemon
PRODUCT_PACKAGES += \
    ims_bridged \
    libnl \
    libimsbrd

# SRMI module files
PRODUCT_PACKAGES += \
    libsrmi \
    srmi_proxyd

# ip monitor
PRODUCT_PACKAGES += ip_monitor.sh

# vowifi bin module
PRODUCT_PACKAGES += \
    vowifi_sdk \
    libavatar \
    libzmf \
    libCamdrv24 \
    liblemon \
    libmme_jrtc \
    ju_ipsec_server

endif
# Enable VOWIFI functions end

# add for linkturbo
# PRODUCT_PACKAGES += \
    LinkTurbo
# add for sprd linkturbo_native service
# PRODUCT_PACKAGES += \
    linkturbonative

#exfat support
PRODUCT_PACKAGES += \
    mount.exfat \
    mkfs.exfat \
    fsck.exfat

PROPMODS :=                                     \
    system/lib/libomx_hevcdec_hw_sprd.so        \
    system/lib/libomx_hevcenc_hw_sprd.so        \
    system/lib/libomx_m4vh263dec_sw_sprd.so     \
    system/lib/libomx_m4vh263enc_sw_sprd.so     \
    system/lib/libomx_m4vh263dec_hw_sprd.so     \
    system/lib/libomx_avcdec_sw_sprd.so         \
    system/lib/libomx_avcdec_vt_sprd.so         \
    system/lib/libomx_avcdec_hw_sprd.so         \
    system/lib/libomx_avcenc_hw_sprd.so         \
    system/lib/libomx_vpxdec_hw_sprd.so         \
    system/lib/libomx_vpxenc_hw_sprd.so         \
    system/lib/libomx_vp9dec_hw_sprd.so         \
    system/lib64/libomx_hevcdec_hw_sprd.so      \
    system/lib64/libomx_hevcenc_hw_sprd.so      \
    system/lib64/libomx_m4vh263dec_sw_sprd.so   \
    system/lib64/libomx_m4vh263enc_sw_sprd.so   \
    system/lib64/libomx_m4vh263dec_hw_sprd.so   \
    system/lib64/libomx_avcdec_sw_sprd.so       \
    system/lib64/libomx_avcdec_vt_sprd.so       \
    system/lib64/libomx_avcdec_hw_sprd.so       \
    system/lib64/libomx_avcenc_hw_sprd.so       \
    system/lib64/libomx_vpxdec_hw_sprd.so       \
    system/lib64/libomx_vpxenc_hw_sprd.so       \
    system/lib64/libomx_vp9dec_hw_sprd.so       \
    vendor/lib/libjpeg_hw_sprd.so               \
    vendor/lib64/libjpeg_hw_sprd.so             \
    vendor/lib/libjpegenc_sw_sprd.so            \
    vendor/lib64/libjpegenc_sw_sprd.so          \
    system/lib/libomx_mp3dec_sprd.so            \
    system/lib/libomx_mp3enc_sprd.so            \
    vendor/bin/thermald                         \
    system/bin/ylog                             \
    system/bin/ylogctl                          \
    system/bin/ylog_lite                        \
    system/bin/yloglitectl                      \
    system/lib/libylog.so                       \
    system/bin/ylogkat                          \
    system/bin/ylogbox                          \
    vendor/bin/yloglitekat


#config video engine for volte video call
ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), true)
PROPMODS += \
    system/app/VceDaemon \
    system/lib/libvideo_call_engine_jni.so \
    system/lib/libvolte_video_service_jni_.so \
    system/lib/libimsbrd.so \
    system/lib/libavatar.so \
    system/lib/libzmf.so \
    system/lib/libCamdrv24.so \
    system/lib/libmme_jrtc.so \
    system/lib64/libvideo_call_engine_jni.so \
    system/lib64/libvolte_video_service_jni_.so \
    system/lib64/libimsbrd.so \
    system/lib64/libavatar.so \
    system/lib64/libzmf.so \
    system/lib64/libCamdrv24.so \
    system/lib64/libmme_jrtc.so \
    system/bin/ims_bridged
endif

