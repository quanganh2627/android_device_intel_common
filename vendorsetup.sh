add_lunch_combo base_x86_legacy-userdebug

if [ -f device/intel/mixins/mixin-update ]; then
    if ! device/intel/mixins/mixin-update --dry-run; then
        echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
        echo '+ Product configuration and mixins are out of sync                      +'
        echo '+ PLEASE RE-RUN device/intel/mixins/mixin-update and commit the result! +'
        echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    fi
fi

mbimg() {
    local T=$(gettop)
    ONE_SHOT_MAKEFILE=device/intel/mixins/groups/kernel/kernel-src.mk make -C $T -f build/core/main.mk kernel || return
    echo ===[ Generating Ramdisk and ${ANDROID_PRODUCT_OUT}/boot.img]===
    (\cd "$T" && make kernel ramdisk-nodeps bootimage-nodeps)
}

mkernel() {
    local T=$(gettop)
    ONE_SHOT_MAKEFILE=device/intel/mixins/groups/kernel/kernel-src.mk make -C $T -f build/core/main.mk BUILD_KERNEL_FROM_SOURCES=1 $*
}
