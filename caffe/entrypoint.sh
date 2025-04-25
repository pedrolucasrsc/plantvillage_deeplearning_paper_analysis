#!/bin/bash
set -e

echo "✅ Entrypoint iniciado"

# 1. PlantVillage data distribution
if [ ! -d "data/lmdb/color-80-20" ] || [ ! -f "data/lmdb/color-80-20/train.txt" ]; then
    echo "➡️  Creating data distributions (.txt mapping files to PlantVillage Dataset)..."
    cd src
    python create_data_distribution.py
    cd ..
else
    echo "✅ Skipping PlantVillage data split (already exists)"
fi

# 2. IPM_dataset .txt generation
if [ ! -f "data/lmdb/IPM_dataset/IPM_dataset.txt" ]; then
    echo "➡️  Creating data distribution (.txt mapping file to IPM_dataset)..."
    python generalization_test/generate_test_dataset_txt.py
else
    echo "✅ Skipping IPM_dataset .txt mapping (already exists)"
fi

# 3. LMDB generation (2 conditions)
cd scripts

NEEDS_GENERATE=false

if [ ! -d "../data/lmdb/color-80-20/train_db" ] || [ ! -f "../data/lmdb/color-80-20/train.txt" ]; then
    echo "⚠️  Missing color-80-20 LMDB. Will generate."
    NEEDS_GENERATE=true
fi

if [ ! -d "../data/lmdb/IPM_dataset/generalization_test_db" ] || [ ! -f "../data/lmdb/IPM_dataset/IPM_dataset.txt" ]; then
    echo "⚠️  Missing IPM_dataset LMDB. Will generate."
    NEEDS_GENERATE=true
fi

if [ "$NEEDS_GENERATE" = true ]; then
    echo "➡️  Generating LMDB databases from the .txt mapping files..."
    bash generate_data.sh
else
    echo "✅ Skipping LMDB generation (already done)"
fi

echo "➡️  Starting ConvNet finetunning..."

cd ../
caffe train \
    -solver train/test_setup_solver.prototxt \
    -weights train/bvlc_googlenet.caffemodel
#&> caffe.log

echo "➡️  Starting inference on IPM_dataset..."

# Run the inference
cd scripts
bash infer_ipm_dataset.sh
