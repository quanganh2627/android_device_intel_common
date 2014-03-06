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

# Print a small help
help_msg='
Intel Build shortcuts:
- mbimg -j4:   fast incremental rebuild of kernel/ramdisk/bootimage.
- mkernel -j4: fast incremental rebuild of kernel
'

echo
hmm | head -n 13
echo "${help_msg}"
