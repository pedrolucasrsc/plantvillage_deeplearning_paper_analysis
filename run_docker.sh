docker built -t caffe-tcc ./caffe
docker run -it -v ./caffe caffe-tcc
#docker run --runtime=nvidia --gpus all -it -v ./caffe caffe-tcc
