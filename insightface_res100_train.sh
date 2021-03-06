export ONEFLOW_DEBUG_MODE=""
export ENABLE_USER_OP=True

emore_data_dir=/data/train_ofrecord/faces_emore
lfw_data_dir=/data/eval_ofrecord/lfw
cfp_fp_data_dir=/data/eval_ofrecord/cfp_fp
agedb_30_data_dir=/data/eval_ofrecord/agedb_30

emore_class_num=85742
gpu_num=1
data_part_num=1
per_gpu_batch_size=32

network="resnet100"
loss_type="margin_softmax"
model_save_dir="output/resnet100_save_model"
log_dir="output/log"

rm -r $model_save_dir
rm -r $log_dir

python3 insightface_train_val.py \
--part_name_suffix_length=5 \
--class_num=$emore_class_num \
--train_data_dir=$emore_data_dir \
--train_batch_size=$(expr $gpu_num '*' $per_gpu_batch_size) \
--train_data_part_num=$data_part_num \
\
--do_validataion_while_train \
--val_batch_size=20 \
--lfw_data_dir=$lfw_data_dir \
--cfp_fp_data_dir=$cfp_fp_data_dir \
--agedb_30_data_dir=$agedb_30_data_dir \
--validataion_interval=1 \
\
--total_batch_num=5 \
--gpu_num_per_node=$gpu_num \
--num_of_batches_in_snapshot=20000 \
--base_lr=0.1 \
--models_name=fc7 \
--model_save_dir=$model_save_dir \
--log_dir=$log_dir \
--network=$network \
--loss_type=$loss_type \
