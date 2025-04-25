import os
# path to the external dataset folder
DATASET_DIR = "/TCC/data/raw/IPM_dataset"
OUTPUT_TXT = "/TCC/data/lmdb/IPM_dataset/IPM_dataset.txt"

class_names = sorted(os.listdir(DATASET_DIR))
class_to_index = {cls: idx for idx, cls in enumerate(class_names)}

with open(OUTPUT_TXT, "w") as f:
    for cls in class_names:
        class_dir = os.path.join(DATASET_DIR, cls)
        if not os.path.isdir(class_dir):
            continue
        for filename in os.listdir(class_dir):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png')):
                image_path = os.path.abspath(os.path.join(class_dir, filename))
                label = class_to_index[cls]
                f.write("{}\t{}\n".format(image_path, label))

print("Written to {}".format(OUTPUT_TXT))
