if [ -f device/intel/mixins/mixin-update ]; then
    if ! device/intel/mixins/mixin-update --dry-run; then
        echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
        echo '+ Product configuration and mixins are out of sync                      +'
        echo '+ PLEASE RE-RUN device/intel/mixins/mixin-update and commit the result! +'
        echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    fi
fi

mkernel() {
    local T=$(gettop)
    local KERNEL_MAKEFILE=$(\cd "$T" && find device -name ${TARGET_PRODUCT}.mk | sed -e "s/${TARGET_PRODUCT}\.mk/AndroidBoard\.mk/")

    if [ ! -f $T/$KERNEL_MAKEFILE ] ; then
        echo "Kernel makefile not found for TARGET_PRODUCT=$TARGET_PRODUCT. abort" 1>&2
        return 1
    fi
    ONE_SHOT_MAKEFILE=$KERNEL_MAKEFILE make -C $T -f build/core/main.mk BUILD_KERNEL_FROM_SOURCES=1 $*
}

mbimg() {
    local T=$(gettop)

    mkernel kernel || return

    echo ===[ Generating Ramdisk and ${ANDROID_PRODUCT_OUT}/boot.img]===
    (\cd "$T" && make BUILD_KERNEL_FROM_SOURCES=1 ramdisk-nodeps bootimage-nodeps)
}
