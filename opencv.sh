#!/bin/bash

# Update repos
yum install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
yum makecache

# Install Dependencies
yum install cmake
yum install python-devel numpy
yum install gcc gcc-c++
yum install gtk4-devel
yum install libdc1394-devel
yum install ffmpeg-devel
yum install gstreamer1-plugins-base-devel

read -p "Do you want to install the optional dependencies? (y/n:) " optional
if [ "$optional" = "y" ]; then
    # Optional Dependencies
    yum install libpng-devel
    yum install libjpeg-turbo-devel
    yum install jasper-devel
    yum install openexr-devel
    yum install libtiff-devel
    yum install libwebp-devel
    yum install tbb-devel
    yum install eigen3-devel
    yum install doxygen
fi

yum install git
git clone https://github.com/opencv/opencv.git

cd opencv

mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_EIGEN=ON -D BUILD_DOCS=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D WITH_OPENCL=OFF -D BUILD_opencv_gpu=OFF -D BUILD_opencv_gpuarithm=OFF -D BUILD_opencv_gpubgsegm=OFF -D BUILD_opencv_gpucodec=OFF -D BUILD_opencv_gpufeatures2d=OFF -D BUILD_opencv_gpufilters=OFF -D BUILD_opencv_gpuimgproc=OFF -D BUILD_opencv_gpulegacy=OFF -D BUILD_opencv_gpuoptflow=OFF -D BUILD_opencv_gpustereo=OFF -D BUILD_opencv_gpuwarping=OFF ..

read -p "Ensure cmake config built correctly. Press any key to continue: " key

make
make install
make doxygen