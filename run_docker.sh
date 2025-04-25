#!/usr/bin/env bash
set -e

IMAGE="caffe-tcc"

echo "➡️  Building $IMAGE …"
docker build -t $IMAGE ./caffe

echo "➡️  Running container with UID=$(id -u) and GID=$(id -g) …"
docker run --rm -it \
  -u $(id -u):$(id -g) \
  -v $(pwd)/caffe:/TCC \
  -v $(pwd)/caffe/data/raw:/TCC/data/raw:ro \
  -v $(pwd)/caffe/data/lmdb:/TCC/data/lmdb \
  -v $(pwd)/caffe/train_results:/TCC/train_results \
  $IMAGE



#docker run --runtime=nvidia --gpus all -it -v $(pwd)/caffe:/TCC caffe-tcc
