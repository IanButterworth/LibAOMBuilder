# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder
name = "LibAOM"
version = v"1.0.0"
# Collection of sources required to build imagemagick

sources = [
    "http://www.andrews-corner.org/downloads/SBo/libaom-1.0.0.r1804.gcb43f766c.tar.gz" =>
  "1337d282ac7b936471b5677558feeefd8a1786f9cac7cf897a08222816a530b9",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
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
