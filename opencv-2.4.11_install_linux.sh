#!/bin/bash
if [ ! -f 2.4.11.zip ]; then
    wget https://github.com/Itseez/opencv/archive/2.4.11.zip
fi
wait
unzip 2.4.11.zip
wait
cd opencv-2.4.11 && mkdir build && cd build

ANACONDA=$HOME/Packages/anaconda2

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/home/wuzz/local -DWITH_CUDA=ON -DCUDA_ARCH_BIN='2.0 2.1(2.0) 3.0 3.5' -DBUILD_opencv_python=ON  -DPYTHON_INCLUDE_DIR=$ANACONDA/include/python2.7/ -DPYTHON_LIBRARY=$ANACONDA/lib/python2.7/ -DBUILD_SHARED_LIBS=YES  ..
wait
make && make install
wait
echo '' >> ~/.bashrc
echo '# opencv python path' >> ~/.bashrc
echo 'export PYTHONPATH=$HOME/Packages/opencv-2.4.11/build/lib:$PYTHONPATH' >> ~/.bashrc
wait
source ~/.bashrc
