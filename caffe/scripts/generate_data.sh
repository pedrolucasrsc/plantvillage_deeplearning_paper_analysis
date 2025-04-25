#!/bin/bash
cd ../src
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m ../data/lmdb/color-80-20/mean.binaryproto  ../data/lmdb/color-80-20/train.txt ../data/lmdb/color-80-20/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  ../data/lmdb/color-80-20/test.txt ../data/lmdb/color-80-20/test_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip ../data/lmdb/IPM_dataset/IPM_dataset.txt ../data/lmdb/IPM_dataset/generalization_test_db 256 256
