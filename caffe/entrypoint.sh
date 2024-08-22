#!/bin/bash
python src/create_data_distribution.py

bash generate_data_color-80-20.sh

caffe train \
    -solver train/solver.prototxt \
    -weights train/bvlc_googlenet.caffemodel \
    -gpu all &> caffe.log