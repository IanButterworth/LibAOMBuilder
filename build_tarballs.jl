# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder
name = "LibAOM"
version = v"1.0.0"
# Collection of sources required to build imagemagick

sources = [
    "https://src.fedoraproject.org/lookaside/pkgs/aom/aom-1.0.0.tar.gz" =>
  "e0c24630961195d9bd65aa8d43732469e8248e8918faa942cfb881769d11515e",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
git clone https://aomedia.googlesource.com/aom
cd aom
apk install yasm
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DBUILD_SHARED_LIBS=1
make -j${ncore}
make install
exit
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products(prefix) = [
]

# Dependencies that must be installed before this package can be built
dependencies = [

]


# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
