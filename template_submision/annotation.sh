#!/bin/bash
#SBATCH --job-name annotation
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 100G


cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/assembly

time prokka assembly.fasta -o ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/annotation --genus Escherichia --species coli --strain C-1 --usegenus
