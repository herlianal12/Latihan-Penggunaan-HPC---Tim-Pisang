#!/bin/bash
#SBATCH --job-name quast
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00:00
#SBATCH --mem 10G


time quast ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/assembly/assembly.fasta -o ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_assembly
