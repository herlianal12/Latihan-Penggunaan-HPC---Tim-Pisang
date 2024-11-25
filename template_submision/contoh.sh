#!/bin/bash
#SBATCH --job-name fastqc
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 1G


time fastqc ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/raw_data/* -o ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control
