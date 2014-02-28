# Rebuild kernel
function mkernel
{
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi
    echo ===[ Building Kernel ]===
    (\cd "$T" && make build_kernel-nodeps $*)
}

# Rebuild kernel and boot.img
function mbimg
{
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi
    echo ===[ Building Kernel ]===
    (\cd "$T" && make build_kernel-nodeps $*)
    echo ===[ Generating Ramdisk and ${ANDROID_PRODUCT_OUT}/boot.img]===
    (\cd "$T" && make ramdisk-nodeps bootimage-nodeps)
}
