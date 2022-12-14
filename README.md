[![Build status](https://build.appcenter.ms/v0.1/apps/5f5c8416-d860-47ba-ad1e-1d2cb2486226/branches/main/badge)](https://appcenter.ms)
# Proyek Akhir Semester PBP

> Kelompok C08:
> 1. Rahmat Bryan Naufal
> 2. Alek Yoanda Partogi Tampubolon
> 3. Hana Devi Aqila
> 4. Emily Rumia Naomi
> 5. Danendra Herdiansyah

Link aplikasi: [BidCare APK](https://install.appcenter.ms/orgs/bidcare/apps/bidcare/distribution_groups/public)
## Deskripsi Aplikasi

- **Nama aplikasi**: BidCare
- **Fungsi aplikasi**: Aplikasi ini bertujuan untuk membantu masyarakat yang membutuhkan donasi berupa uang, dimana uang donasinya didapatkan melalui hasil lelang barang. Selain itu, aplikasi ini juga dapat menjadi platform jual beli barang lelang yang 70% hasil dari penjualan barang lelang akan disumbangkan kepada galang dana yang dipilih.
- **Peran/aktor pengguna aplikasi**: 
  1. Role umum belum login: Login  atau Register bagi belum mempunyai akun <br>
  2. Role Umum sudah login: Bisa melihat informasi lengkap pada dashboard, melihat dan membuat komentar barang lelang dan galang dana, membuat testimoni
  
## Daftar Modul Yang Akan Diimplementasikan
  1. **General User (Bryan)** => Segala sesuatu mencakup dasar sebuah website: dashboard, login, register, logout
  - Model: 
      - Custom User model yang memiliki atribut tambahan no telpon, dan one to one relationship dengan model Rekening Bank
      - Rekening Bank dengan atribut nama pemilik rekening, jenis bank (choices), no rekening
  - Page:
      - Halaman ke login page (1 file dart)
      - Halaman ke register page (1 file dart)
      - Halaman ke dashboard page (1 file dart)
  - Input: 
    - Form login
    - Form register
    <br>
  2. **Lelang (Alek)** => Segala sesuatu terkait pelelangan: buat pelelangan baru, lihat daftar lelang (aktif maupun tidak aktif), lihat rincian objek lelang
  - Model:
      - Barang Lelang dengan atribut: Foreign Key terhadap objek dari model User yang membuat objek barang lelang ini (Satu objek User bisa membuat lebih dari 1 pelelangan, oleh karena itu hubungannya one-to-many => Foreign Key), nama barang, deskripsi barang, starting bid, gambar, tanggal lelang dibuat, kategori barang lelang (berupa choices), status keaktifan lelang, tanggal berakhirnya lelang (durasi pelelangan), Foreign Key terhadap objek model Galang Dana/Resipien (satu objek Galang Dana bisa dipilih oleh banyak objek pelelangan agar hasil penjualan barang lelang akan didonasikan ke objek Galang Dana tersebut => one-to-many => Foreign Key)
      - Bid dengan atribut: Foreign Key terhadap objek dari model User yang membuat mem-bid suatu barang lelang, Foreign Key terhadap objek dari model Barang Lelang dimana suatu bid ini ditujukan, banyak bid (dalam rupiah)
      - Komentar dengan atribut:  Foreign Key terhadap objek dari model User yang membuat berkomentar pada suatu barang lelang, Foreign Key terhadap objek dari model Barang Lelang dimana Objek Komentar ini ditujukan, teks komentar, tanggal komentar dibuat
  - Page:
    - Halaman lihat daftar barang lelang (1 file dart)
    - Halaman buat barang lelang baru (1 file dart)
    - Halaman rincian objek barang lelang (1 file dart)
  - Input: 
      - Form buat barang lelang baru
      - Form bidding barang lelang (jumlah bid)
      - Form komentar
    <br>
  3. **Resipien (Emily)** => Segala sesuatu terkait dengan galang dana/resipien: buat penggalangan dana, lihat daftar galang dana, lihat rincian objek galang dana
  - Model (data respons JSON dari web service Django): 
    - Galang Dana dengan atribut:  Foreign Key terhadap objek dari model User yang membuat penggalangan dana ini, judul galang dana, gambar, deskripsi galang dana, target uang terkumpul, tanggal berakhirnya galang dana (durasi galang dana), one-to-one relationship dengan objek pada model Rekening Bank penggalang , ditujukan untuk keperluan (choices => pribadi, keluarga, institusi, teman atau lainnya), status keaktifan galang dana
    - Komentar dengan atribut:  Foreign Key terhadap objek dari model User yang membuat berkomentar pada suatu objek Galang Dana, Foreign Key terhadap objek dari model Galang Dana dimana Objek Komentar ini ditujukan, teks komentar, tanggal komentar dibuat
    Untuk tambah keperluan data galang dana dan komentar:
      - Akun User dengan atribut: username, first name, dan last name
      - Akun Bank dengan atribut: nama bank, nama pemilik, dan no rekening
  - Page:
    - Halaman main galang dana button ke halaman daftar galang dana dan halaman buat galang dana (1 file dart)
    - Halaman ke lihat daftar galang dana (1 file dart)
    - Halaman ke buat penggalangan dana (1 file dart)
    - Halaman lihat detail objek galang dana (1 file dart)
  - Input:
    - Form pembuatan penggalangan dana
    - Form komentar
    <br>
  4. **Customer Service (Hana)** => Segala sesuatu terkait bantuan penggunaan terhadap aplikasi BidCare: form pertanyaan terhadap cs, kumpulan FAQ
  - Model:
    - FAQ dengan atribut: pertanyaan, jawaban 
    - Pertanyaan dengan atribut: teks pertanyaan, kategori pertanyaan (choices => lelang, galang dana, umum)
  - Page:
    - Halaman FAQ (1 file dart)
    - Halaman form pertanyaan (1 file dart)
    - Halaman display pertanyaan (1 file dart)
    - Halaman form jawaban (1 file dart)
  - Halaman form:
    - Form pertanyaan
    - Form jawaban
    <br>
  5. **Testimoni (Danendra)** => Segala sesuatu mencakup cerita dan testimoni dari resipien maupun user umum: form testimoni, kumpulan testimoni
  - Model: 
    - Testimoni dengan atribut: Foreign Key dari objek model User, target, dan cerita atau ucapan terima kasih
  - Page:
    - Halaman ke form testimoni page (1 file dart)
    - Halaman ke daftar testimoni page (1 file dart)
  - Halaman form:
    - Form testimoni
    <br>
## Alur Pengintegrasian Dengan _web service_
Integrasi projek aplikasi flutter dengan _web service_ dilakukan dengan menggunakan API endpoint pada data JSON yang terdapat di projek Django sebelumnya dengan respon berupa JsonResponse. Penghubungan, pengambilan, maupun penempatan data pada aplikasi flutter _mobile_ akan mengambil data dari aplkasi web yang sudah di-_deploy_ ke Heroku yang kemudian menggunakan _dependency_ `Http` melalui _HTTP request_ secara _asynchronous_.
