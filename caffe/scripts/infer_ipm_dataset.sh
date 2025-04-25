#!/bin/bash
set -e

MODEL_WEIGHTS="/TCC/train_results/snapshots_iter_54690.caffemodel"  # or adjust the snapshot you want to use
DEPLOY_PROTOTXT="/TCC/generalization_test/deploy.prototxt"  # You will need a deploy.prototxt (I explain below)
MEAN_FILE="/TCC/data/lmdb/color-80-20/mean.binaryproto"
LABELS_FILE="/TCC/data/lmdb/color-80-20/labels.txt"
IPM_LMDB="/TCC/data/lmdb/IPM_dataset/generalization_test_db"

OUTPUT_DIR="/TCC/train_results/ipm_inference"
mkdir -p "$OUTPUT_DIR"

echo "➡️  Performing inference on IPM_dataset..."

# Assuming you have 'caffe' CLI available inside container
caffe test \
    -model "$DEPLOY_PROTOTXT" \
    -weights "$MODEL_WEIGHTS" \
    -iterations 12 2>&1 | tee "$OUTPUT_DIR/inference.log"

echo "✅ Inference finished. Results saved in $OUTPUT_DIR"

