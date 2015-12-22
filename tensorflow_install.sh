#!/usr/bin/bash

git clone --recurse-submodules https://github.com/tensorflow/tensorflow

wget https://github.com/bazelbuild/bazel/releases/download/0.1.1/bazel-0.1.1-installer-linux-x86_64.sh
BAZEL_INSTALLER=bazel-0.1.1-installer-linux-x86_64.sh
chmod +x $BAZEL_INSTALLER

if [ ! -f $HOME/local ]; then
    echo 'mkdir ' $HOME/local
    mkdir $HOME/local
fi

./$BAZEL_INSTALLER --bin=$HOME/local/bin --base=$HOME/.bazel --bazelrc=$HOME/.bazelrc

# sudo apt-get install python-numpy swig python-dev

cd tensorflow && ./configure
bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
bazel-bin/tensorflow/cc/tutorials_example_trainer --use_gpu
