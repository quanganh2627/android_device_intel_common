#Test and eng packages
PRODUCT_PACKAGES_ENG += \
    AsfCtc \
    ASF_CTC \
    DeviceHookTest \
    Inotify_test \
    libsv_test \
    IntelFMStackTestApp \
    DownloadTool \
    FlsTool \
    CC6_UMIP_ACCESS_APP \
    CC6_SIGNED_IMAGE_VERIFY \
    LIBSECURITY_API_STUB_SHARED \
    LIBSECURITY_API_STUB_STATIC \
    SEC_TOOLS \
    hwc-overlay \
    InfiniteThreadApp \
    LinkedListService \
    RecursiveFunctionApp \
    mutex_stress \
    RebootCounter \
    AlarmApplication \
    VideoApplication \
    blit_test \
    pvr_test \
    Timer \
    test_widi_audiocapturesrc \
    test_extmode_security \
    test_widi_fwupgrade_cli \
    test_widi_fwupgrade \
    test_auto_connect \
    test_widi_p2p_cli \
    test_widi_p2p \
    test_widi_p2p_cc \
    test_libwidip2p_cli \
    test_widi_rtsp_cli \
    test_widi_rtspsrc \
    widirtspsink \
    test_widi_streaming \
    test_widi_ub_mode \
    test_widi_videocapturesrc \
    test_wifi_latency \
    flashtool \
    test_alek \
    bist_test \
    calibration \
    imginfo \
    TXEI_TEST \
    TXEI_SEC_TOOLS \
    iperf

ifeq ($(BOARD_HAVE_MODEM), true)
PRODUCT_PACKAGES_ENG += \
    mts-test \
    modem_test
endif

PRODUCT_PACKAGES_DEBUG += \
    ssploop \
    sspconf \
    audience_write \
    ct_monitor \
    testsigmartspcmds \
    camtest_Features \
    kcmdline \
    peeknpoke \
    powerbot \
    purgatory-i386 \
    kexec-i386 \
    phonemonitor \
    crashlogd \
    libdebug_anr \
    parse_stack \
    ad_drv_test \
    gtester
