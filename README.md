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

1. Mempersiapkan software/tools menjadi dapat diakses
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
   [//]: <img width="587" alt="Screenshot 2024-05-05 at 19 38 04" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/f0b88b62-582b-4574-b894-fdf129bab0c4">

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
   git clone https://github.com/hpc-mahameru/Bioinformatics-User-Meeting.git
   ```

4. **Membuat folder proyek untuk menyimpan data input dan output**
   ```
   cd ~/Bioinformatics-User-Meeting
   mkdir -p training
   cd training
   mkdir raw_data quality_control
   cd ~
   ```

5. **Mengunduh data mentah dengan wget**
   Gunakan perintah ```wget``` untuk mengunduh data.
   Sebelumnya, kembali ke home terlebih dahulu
   ```
   cd
   ```
   Download raw data untuk training.
   ```
   wget https://zenodo.org/record/940733/files/illumina_f.fq -P Bioinformatics-User-Meeting/training/raw_data
   wget https://zenodo.org/record/940733/files/illumina_r.fq -P Bioinformatics-User-Meeting/training/raw_data
   wget https://zenodo.org/record/940733/files/minion_2d.fq -P Bioinformatics-User-Meeting/training/raw_data
   
   ```
   source: https://training.galaxyproject.org/training-material/topics/assembly/tutorials/unicycler-assembly/tutorial.html

6. **Bekerja dengan mode interaktif**
   ```
   srun --partition=interactive --pty /bin/bash
   ```
   Perhatikan nama host-nya, berubah menjadi trembesi91/92
   ```
   module load multiqc
   cd Bioinformatics-User-Meeting/training/quality_control
   multiqc .
   exit
   ```

   Hasil:
   ```
   cd ~/Bioinformatics-User-Meeting/training/quality_control
   ls
   ```
   <img width="594" alt="Screenshot 2024-05-05 at 20 14 12" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/83d72052-42d0-4c89-b4ca-90eb663ff2f2">

9. **Bekerja dengan menggunakan skrip job**

   ```
   cd ~
   cd Bioinformatics-User-Meeting/template_submision
   less contoh.sh
   ```
   <img width="834" alt="Screenshot 2024-05-05 at 19 45 45" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/cc6659da-3e08-4ffb-8ac4-3d201ee14be0">
   
    ```
   sbatch contoh.sh
   squeue
   ```
   <img width="495" alt="Screenshot 2024-05-05 at 19 59 36" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/5e0aa0e9-ffec-4dc7-ac11-1e8d52897614">
   
   ```
   cd ~
   cd Bioinformatics-User-Meeting/training/quality_control
   ls
   ```
   
11. **Transfer data dari HPC Mahameru BRIN ke lokal**
    Memindahkan file html ke folder baru dengan nama html
    ```
    cd ~/Bioinformatics-User-Meeting/training/quality_control
    mkdir html
    mv *.html html/
    cd html
    ls
    ```
    <img width="638" alt="Screenshot 2024-05-05 at 20 22 34" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/d79e79da-c759-4d58-8931-41ea83cff3a5">
    
    Buka terminal atau powershell yang baru untuk transfer file

    Contoh:
    ```
    scp -r lina008@login2.hpc.brin.go.id:~/Bioinformatics-User-Meeting/training/quality_control/html Downloads
    ```
    Buka masing-masing html file dengan double klik report qc dari masing-masing sampel yang ada di folder Downloads.

    Fastqc short read
    <img width="1438" alt="Screenshot 2024-05-05 at 20 38 59" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/17c2f071-662e-428e-8275-78eb28114ded">

    Fastqc long read
    <img width="1431" alt="Screenshot 2024-05-05 at 20 39 18" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/a7aa06ca-6fc4-4291-832c-4476293b56d9">

    Multiqc result:
    <img width="1437" alt="Screenshot 2024-05-05 at 20 38 16" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/23def188-5ddd-47d9-a1f1-7cd20b1af389">



## **OPTIONAL Unicycler assembly tutorial**

1. **Mempersiapkan software/tools menjadi dapat diakses**
   ```
   module load prokka unicycler quast barrnap
   ```
2. **Membuat direktori baru**
   ```
   cd ~
   mkdir Bioinformatics-User-Meeting/training/assembly
   ```
3. **Melakukan assembly dengan unicycler**
   ```
   cd /mgpfs/home/lina008/Bioinformatics-User-Meeting/template_submision
   sbatch assembly.sh
   ```
   Check log dan hasil assembly:
   
   <img width="633" alt="image" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/b7c60f78-03ac-4752-b9cb-cbbb73fd89cc">

   <img width="647" alt="Screenshot 2024-05-05 at 21 03 44" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/e077df04-a326-4081-a873-72c58a2ca569">

   
4. **Mengevaluasi kualitas assembly dengan quast**

   ```
   cd ~/Bioinformatics-User-Meeting/template_submision
   sbatch quality_assembly.sh
   cd ~/Bioinformatics-User-Meeting/training/quality_assembly
   ls
   ```
   <img width="701" alt="Screenshot 2024-05-05 at 21 16 32" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c9fdd7fc-2a89-49fe-bc36-20ac310a0fb8">
   
   Hasil:
   <img width="1104" alt="Screenshot 2024-05-05 at 21 18 10" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/0754f487-470f-422f-9511-d24df99a3da7">


5. **Akses database lokal untuk bioinformatics**
   ```
   ### list database yang sudah ada (tidak dipakai untuk training hanya informasi)
   ls /mgpfs/db/bioinformatics
   ```
   <img width="580" alt="Screenshot 2024-05-05 at 20 09 49" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c73acd11-1c5c-42d5-b246-3160962559ff">

   Silahkan untuk melakukan permohonan penambahan database dengan mengirimkan email dengan judul "Database Bioinformatics", sertakan juga link database

6. **Melakukan anotasi dengan prokka**
   ```
   cd ~/Bioinformatics-User-Meeting/template_submision
   sbatch annotation.sh
   cd ~/Bioinformatics-User-Meeting/training/annotation
   ls -lh
   ```
   <img width="501" alt="image" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/5503011d-49d1-4ded-a074-fd3295efccd6">


7. **Visualisasi anotasi dengan IGV**

   - Download IGV di laptop masing-masing: https://igv.org/doc/desktop/#DownloadPage/
   - Transfer folder annotation dari HPC ke folder di laptop masing-masing seperti contoh sebelumnya
   - Transfer file assembly.fasta dari HPC ke folder di laptop masing-masing seperti contoh sebelumnya
   - Buka software IGV dengan double click icon IGV
   - Pilih Genomes --> Load Genome from file --> pilih assembly.fasta
   - Pilih File --> Load from file --> pilih gff file contoh PROKKA_05052024.gff
     <img width="1330" alt="image" src="https://github.com/hpc-mahameru/Bioinformatics-User-Meeting/assets/57382343/c788d652-348f-468c-bf6b-e6513b90b999">

