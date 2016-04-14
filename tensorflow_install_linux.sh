#!/bin/bash

git clone --recurse-submodules https://github.com/tensorflow/tensorflow

BAZEL_INSTALLER=bazel-0.1.4-installer-linux-x86_64.sh
if [ ! -f $BAZEL_INSTALLER ]; then
    wget https://github.com/bazelbuild/bazel/releases/download/0.1.4/$BAZEL_INSTALLER
fi

chmod +x $BAZEL_INSTALLER

if [ ! -f $HOME/local ]; then
    echo 'mkdir ' $HOME/local
    mkdir $HOME/local
fi

./$BAZEL_INSTALLER --bin=$HOME/local/bin --base=$HOME/.bazel --bazelrc=$HOME/.bazelrc

# sudo apt-get install python-numpy swig python-dev

cd tensorflow && ./configure
bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
TMP_PKG=$HOME/tmp/tensorflow_pkg

if [ ! -f $TMP_PKG ]; then
    echo 'mkdir' $TMP_PKG
    mkdir -p $TMP_PKG
fi

rm -f $TMP_PKG/*
bazel-bin/tensorflow/tools/pip_package/build_pip_package $TMP_PKG
pip install $(echo $TMP_PKG/*whl)


#bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
#bazel-bin/tensorflow/cc/tutorials_example_trainer --use_gpu
