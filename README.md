# RSUD Otista Mobile

Project Flutter untuk aplikasi `RSUD Otista Mobile`.

Branding utama:

- Nama aplikasi: `RSUD Otista Mobile`
- Nama lengkap: `RSUD Oto Iskandar Di Nata Kabupaten Bandung`
- Version: `1.0.0`

Identitas rumah sakit:

- Alamat: `Jl. Gading Tutuka, RT 01 RW 01, Kp. Cincin Kolot, Kec. Soreang, Kab. Bandung, Jawa Barat`
- Website: `https://rsudotista.bandungkab.go.id/`
- Email: `rsudotista@bandungkab.go.id`

Konfigurasi API:

- Prod default: `https://api-mobile.rsudotista.my.id/api/v1`
- Health prod: `https://api-mobile.rsudotista.my.id/api/v1/health`
- Dev lokal: `flutter run --dart-define=APP_ENV=dev --dart-define=DEV_API_BASE_URL=http://localhost:8080/api/v1`
- Override umum: `flutter run --dart-define=API_BASE_URL=http://localhost:8080/api/v1`
- Override prod: `flutter run --dart-define=APP_ENV=prod --dart-define=PROD_API_BASE_URL=https://api-mobile.rsudotista.my.id/api/v1`
- Android emulator biasanya perlu memakai host mesin: `--dart-define=API_BASE_URL=http://10.0.2.2:8080/api/v1`

## Mode portofolio offline

Gunakan mode ini untuk demo atau pengambilan screenshot tanpa membaca sesi pasien
dan tanpa membuat koneksi ke API:

```sh
flutter run -d emulator-5554 --dart-define=PORTFOLIO_MODE=true
```

Build Android dengan flag tersebut memakai application ID
`id.go.bandungkab.rsudotista.mobile.portfolio` dan label
`Portal Pasien Demo`, sehingga dapat dipasang berdampingan dengan aplikasi
normal. Aplikasi langsung membuka empat workflow sintetis—Layanan, Antrian,
Rekam, dan Profil—sebelum provider API atau secure storage normal dibuat.

Setiap layar menampilkan watermark
`PORTOFOLIO • DATA SINTETIS • OFFLINE`. Jangan mengambil screenshot native
splash karena resource splash masih mengikuti aplikasi normal; tunggu sampai
watermark Flutter terlihat.
