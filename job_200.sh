#!/bin/bash
#PBS -P sz65
#PBS -l ncpus=12
#PBS -l ngpus=1
#PBS -q gpuvolta
#PBS -l mem=64GB
#PBS -l storage=scratch/sz65
#PBS -l walltime=24:00:00
#PBS -l jobfs=100GB

module load pytorch/1.9.0
cd /scratch/sz65/cc0395/LT_ECCV
source my_env/bin/activate
cd /scratch/sz65/cc0395/MiSLAS

echo "Script executed from: ${PWD}"

export WANDB_DIR=/scratch/sz65/cc0395/MiSLAS
export WANDB_CACHE_DIR=/scratch/sz65/cc0395/wandb/.cache
export WANDB_CONFIG_DIR=/scratch/sz65/cc0395/wandb/.config
export WANDB_MODE=offline

python train_stage1.py --cfg ./config/cifar10/cifar10_imb0005_stage1_mixup.yaml
python train_stage2.py --cfg ./config/cifar10/cifar10_imb0005_stage2_mislas.yaml resume /scratch/sz65/cc0395/MiSLAS/saved/cifar10_imb0005_stage1_mixup/ckps/model_best.pth.tar




# qsub -I -qgpuvolta  -Psz65 -lwalltime=01:00:00,ncpus=12,ngpus=1,mem=64GB,jobfs=1GB,wd