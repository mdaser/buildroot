
# assumes: we call from the buildroot directory
toolchainpath="$(pwd)/output/host/bin"

# just pick the first one ... there might be aliases
# -dumpmachine will list the original one
gcc=$(find ${toolchainpath} -name "*-gcc" | sort | head -1)
cross="$(${gcc} -dumpmachine)-"
arch=${cross%%-*}
sysroot=$(${gcc} -print-sysroot)
toolchaindir=$(dirname ${gcc})

if [ "${arch}" = "aarch64" ]
then
    arch="arm64"
fi

# TODO: clean old environment: remove old toolchain path

# set new environment ...
export ARCH=${arch}
export CROSS_COMPILE=${cross}
export SYSROOT=$(cd ${sysroot} && pwd)
export PATH=${toolchaindir}:$PATH

export GCC=${toolchaindir}/${cross}gcc
export GDB=${toolchaindir}/${cross}gdb

# make alias
alias tcmake="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} "

echo "========================================="
echo " ARCH         : ${ARCH}"
echo " CROSS_COMPILE: ${CROSS_COMPILE}"
echo " SYSROOT      : ${SYSROOT}"
echo " PATH         : ${toolchaindir}"
echo "========================================="
alias tcmake
echo "========================================="