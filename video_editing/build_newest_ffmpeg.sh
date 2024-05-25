#!/bin/bash

# URL:
# https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu#FFmpeg

PREFIX=$HOME/.local/ffmpeg

sudo apt update -qq && sudo apt -y install \
    autoconf \
    automake \
    build-essential \
    cmake \
    git-core \
    libass-dev \
    libfreetype6-dev \
    libgnutls28-dev \
    libmp3lame-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    meson \
    ninja-build \
    pkg-config \
    texinfo \
    wget \
    yasm \
    nasm \
    zlib1g-dev \
    libx264-dev \
    libx265-dev libnuma-dev \
    libfdk-aac-dev

mkdir -p tmp/
pushd tmp/

git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && \
mkdir -p aom_build && \
cd aom_build && \
PATH="$PREFIX/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$PREFIX" -DENABLE_TESTS=OFF -DENABLE_NASM=on ../aom && \
PATH="$PREFIX/bin:$PATH" make -j`nproc` && \
make install && \
cd ..

wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
PATH="$PREFIX/bin:$PATH" PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig" ./configure \
    --prefix="$PREFIX" \
    --pkg-config-flags="--static" \
    --extra-cflags="-I$PREFIX/include" \
    --extra-ldflags="-L$PREFIX/lib" \
    --extra-libs="-lpthread -lm" \
    --ld="g++" \
    --bindir="$PREFIX/bin" \
    --enable-gpl \
    --enable-libaom \
    --enable-libfdk-aac \
    --enable-libx264 \
    --enable-libx265 \
    --enable-nonfree && \
PATH="$PREFIX/bin:$PATH" make -j`nproc` && \
make install && \
cd ..

#   --enable-libass \
#   --enable-gnutls \
#   --enable-libfreetype \
#   --enable-libmp3lame \
#   --enable-libopus \
#   --enable-libsvtav1 \
#   --enable-libdav1d \
#   --enable-libvorbis \
#   --enable-libvpx \


popd tmp/