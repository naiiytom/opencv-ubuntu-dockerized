FROM ubuntu:focal

LABEL MAINTAINER="Yuttapichai Lamnaonan | y.lamnaonan@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Bangkok

RUN apt-get update --fix-missing && \
    apt-get install -y build-essential cmake git wget unzip yasm pkg-config \
    libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev \
    libv4l-dev libxvidcore-dev libx264-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy python3-pip \
    libtbb2 libtbb-dev libdc1394-22-dev && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

WORKDIR /
ARG OPENCV_VERSION="4.4.0"

RUN wget -q https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
    && cd /opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake \
    -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DOPENCV_ENABLE_NONFREE=ON \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python3) \
    -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
    .. \
    && make -j`grep -c '^processor' /proc/cpuinfo` \
    && make install \
    && rm /${OPENCV_VERSION}.zip \
    && rm -r /opencv-${OPENCV_VERSION}

RUN ln -s \
    /usr/local/python/cv2/python-3.8/cv2.cpython-38m-x86_64-linux-gnu.so \
    /usr/local/lib/python3.8/dist-packages/cv2.so


ENTRYPOINT [ "/bin/bash" ]
