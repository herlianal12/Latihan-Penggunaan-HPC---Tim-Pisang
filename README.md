# Latihan Penggunaan HPC - Tim Pisang
26 November 2024

Tujuan: Pengguna HPC khususnya bidang bioinformatika dapat memanfaatkan fasilitas komputasi secara maksimal

Hal yang perlu diperhatikan sebelum hands-on
1. Akun aktif HPC Mahameru BRIN Gen 4 (daftar melalui https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393)
2. Laptop
3. Akses Internet

## **Overview**
**Persiapan and Evaluasi kualitas hasil sekuensing (QC)**
1. Masuk ke HPC (Login)
2. Membuat screen session
3. Mengkloning repositori
4. Membuat direktori
5. Mengunduh data mentah (raw data)
6. Mempersiapkan software/tools menjadi dapat diakses
7. Mengirimkan job dengan sbatch
8. Menggunakan interaktif job submission
9. Mentransfer atau mengunduh file dari HPC ke komputer user

**OPTIONAL Unicycler assembly tutorial**

1. Membuat environment baru dan menginstall software untuk assembly
2. Membuat direktori baru
3. Melakukan assembly dengan unicycler
4. Mengevaluasi kualitas assembly dengan quast
5. Mengakses database lokal
6. Melakukan anotasi dengan prokka
7. Mengvisualisasikan hasil dengan IGV


## **Tahapan**:
1. **Masuk ke HPC Mahameru BRIN menggunakan akun masing-masing melalui terminal (Mac/Linux) atau powershell (Windows)**
   ```
   ssh <username>@login2.hpc.brin.go.id
   ```
   <img width="712" alt="image" src="https://github.com/user-attachments/assets/ace3c4a4-981a-4ef5-ae70-202d51d01293">

2. **Menggunakan bantuan screen untuk membuat beberapa sesi dan mempertahankan sesi yang ada walau koneksi terputus.** \
   User dapat menggunakan aplikasi lain seperti tmux
   ```
   ### Membuat screen session
   screen -S training

   ### Mengakses screen session kembali setelah logout atau putus sambungan
   screen -dr training
   ```
3. **Mengkloning repository pelatihan**
   ```
   git clone https://github.com/herlianal12/Latihan-Penggunaan-HPC---Tim-Pisang.git
   ```

4. **Membuat folder proyek untuk menyimpan data input dan output**
   ```
   cd Latihan-Penggunaan-HPC---Tim-Pisang
   mkdir -p training
   cd training
   mkdir raw_data quality_control
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang
   ls
   ```
   <img width="640" alt="image" src="https://github.com/user-attachments/assets/2a5e8f9a-3983-4b68-be72-fa9daf0f6204">


5. **Mengunduh data mentah dengan wget (JANGAN DILAKUKAN SAAT TRAINING)**
   Gunakan perintah ```wget``` untuk mengunduh data.
   Sebelumnya, kembali ke home terlebih dahulu
   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang
   ```
   Download raw data untuk training.
   ```
   wget https://zenodo.org/record/940733/files/illumina_f.fq -P training/raw_data
   wget https://zenodo.org/record/940733/files/illumina_r.fq -P training/raw_data
   wget https://zenodo.org/record/940733/files/minion_2d.fq -P training/raw_data
   
   ```
   source: https://training.galaxyproject.org/training-material/topics/assembly/tutorials/unicycler-assembly/tutorial.html
   
   **Menyalin data dari database lokal (LAKUKAN INI SAAT TRAINING)**
   Karena mengunduh data dapat memakan waktu yang lama, untuk training ini kita akan menyalin data yang telah diunduh

   ```
   cp -r /mgpfs/db/bioinformatics/raw_data ~/Latihan-Penggunaan-HPC---Tim-Pisang/training
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/raw_data
   ls
   ```
   <img width="451" alt="image" src="https://github.com/user-attachments/assets/ce67d2f6-7218-46c5-80d7-078fd5e18e27">


6. **Mempersiapkan software/tools menjadi dapat diakses**

   ```
   module avail
   module load bioinformatics/fastqc/0.12.1
   ```

7. **Bekerja dengan menggunakan skrip job**

   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/template_submision
   less contoh.sh
   #tekan q untuk keluar
   ```
   <img width="1219" alt="image" src="https://github.com/user-attachments/assets/a6954023-660d-43d0-acd2-a70d1e20aeaa">

    ```
   sbatch contoh.sh
   squeue
   ```
   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control
   ls
   ```
   <img width="1283" alt="image" src="https://github.com/user-attachments/assets/f0b2f7a2-fc95-4258-a963-31264ec03ec2">
   **JIKA ADA MASALAH, gunakan mode interaktif***

9. **Bekerja dengan mode interaktif**
   ```
   srun --partition=interactive --pty /bin/bash
   ```
   Perhatikan nama host-nya, berubah menjadi trembesi91/92

   ```
   module load bioinformatics/fastqc/0.12.1
   time fastqc ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/raw_data/* -o ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control
   exit
   ```

   Hasil:
   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control
   ls
   ```
   
   <img width="1340" alt="image" src="https://github.com/user-attachments/assets/b51cb5fb-ae82-405a-920c-07b53732e5a0">

   
11. **Transfer data dari HPC Mahameru BRIN ke lokal**
    Memindahkan file html ke folder baru dengan nama html
    ```
    cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control
    mkdir html
    mv *.html html/
    cd html
    ls
    ```
    <img width="691" alt="image" src="https://github.com/user-attachments/assets/c911c536-ecab-421c-a102-7490b2fbb03d">

    
    Buka terminal atau powershell yang baru untuk transfer file

    Contoh:
    ```
    scp -r lina008@login2.hpc.brin.go.id:~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_control/html Downloads
    ```
    Buka masing-masing html file dengan double klik report qc dari masing-masing sampel yang ada di folder Downloads.

    Fastqc short read
    <img width="1438" alt="Screenshot 2024-05-05 at 20 38 59" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/17c2f071-662e-428e-8275-78eb28114ded">

    Fastqc long read
    <img width="1431" alt="Screenshot 2024-05-05 at 20 39 18" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/a7aa06ca-6fc4-4291-832c-4476293b56d9">


## **OPTIONAL Unicycler assembly tutorial**

1. **Membuat environment baru dan menginstall software untuk assembly**
   ```
   module load bioinformatics/miniforge3/24.3.0-0
   mamba create -n assembly_test
   mamba init
   source ~/.bashrc
   mamba activate assembly_test
   mamba install -c bioconda prokka=1.14.6 unicycler=0.4.7 quast=5.0.2 barrnap=0.9
   ```
   
2. **Membuat direktori baru**
   ```
   cd ~
   mkdir Latihan-Penggunaan-HPC---Tim-Pisang/training/assembly
   ```
3. **Melakukan assembly dengan unicycler**

   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/template_submision
   sbatch assembly.sh
   ```
   
   Check hasil assembly:
   
   <img width="647" alt="Screenshot 2024-05-05 at 21 03 44" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/e077df04-a326-4081-a873-72c58a2ca569">

   
5. **Mengevaluasi kualitas assembly dengan quast**

   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/template_submision
   sbatch quality_assembly.sh
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/quality_assembly
   ls
   ```
   <img width="701" alt="Screenshot 2024-05-05 at 21 16 32" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c9fdd7fc-2a89-49fe-bc36-20ac310a0fb8">
   
   Hasil:
   <img width="1104" alt="Screenshot 2024-05-05 at 21 18 10" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/0754f487-470f-422f-9511-d24df99a3da7">


6. **Akses database lokal untuk bioinformatics**
   ```
   ### list database yang sudah ada (tidak dipakai untuk training hanya informasi)
   ls /mgpfs/db/bioinformatics
   ```
   <img width="580" alt="Screenshot 2024-05-05 at 20 09 49" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c73acd11-1c5c-42d5-b246-3160962559ff">

   Silahkan untuk melakukan permohonan penambahan database dengan mengirimkan email dengan judul "Database Bioinformatics", sertakan juga link database

7. **Melakukan anotasi dengan prokka**
   ```
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/template_submision
   sbatch annotation.sh
   cd ~/Latihan-Penggunaan-HPC---Tim-Pisang/training/annotation
   ls -lh
   ```
   <img width="501" alt="image" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/5503011d-49d1-4ded-a074-fd3295efccd6">


8. **Visualisasi anotasi dengan IGV**

   - Download IGV di laptop masing-masing: https://igv.org/doc/desktop/#DownloadPage/
   - Transfer folder annotation dari HPC ke folder di laptop masing-masing seperti contoh sebelumnya
   - Transfer file assembly.fasta dari HPC ke folder di laptop masing-masing seperti contoh sebelumnya
   - Buka software IGV dengan double click icon IGV
   - Pilih Genomes --> Load Genome from file --> pilih assembly.fasta
   - Pilih File --> Load from file --> pilih gff file contoh PROKKA_05052024.gff
     <img width="1330" alt="image" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c788d652-348f-468c-bf6b-e6513b90b999">

