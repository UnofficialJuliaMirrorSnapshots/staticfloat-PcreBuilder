using BinaryBuilder

# Collection of sources required to build Pcre
sources = [
    "https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.bz2" =>
    "2cd04b7c887808be030254e8d77de11d3fe9d4505c39d4b15d2664ffe8bf9301",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd pcre-8.42/
./configure --prefix=$prefix --host=$target
make -j${nproc}
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    BinaryProvider.Linux(:i686, :glibc),
    BinaryProvider.Linux(:x86_64, :glibc),
    BinaryProvider.Linux(:aarch64, :glibc),
    BinaryProvider.Linux(:armv7l, :glibc),
    BinaryProvider.Linux(:powerpc64le, :glibc),
    BinaryProvider.MacOS(),
    BinaryProvider.Windows(:i686),
    BinaryProvider.Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libpcre", :libpcre)
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "pcre", sources, script, platforms, products, dependencies)

