class PortfolioServiceItem {
  const PortfolioServiceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.metric,
  });

  final String id;
  final String title;
  final String subtitle;
  final String metric;
}

class PortfolioMedicalResult {
  const PortfolioMedicalResult({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String category;
  final String title;
  final String subtitle;
  final String status;
}

class PortfolioVisit {
  const PortfolioVisit({
    required this.date,
    required this.service,
    required this.summary,
    required this.status,
  });

  final String date;
  final String service;
  final String summary;
  final String status;
}

class PortfolioDemoData {
  const PortfolioDemoData._();

  static const String patientName = 'Pasien Demo';
  static const String patientId = 'DEMO-0001';
  static const String patientEmail = 'pasien.demo@example.invalid';

  static const String bookingPolyclinic = 'Poli Umum Demo';
  static const String bookingDoctor = 'Dokter Layanan Demo';
  static const String bookingDate = '15 Juli 2026';
  static const String bookingTime = '09.00 - 11.00';
  static const String queueNumber = 'A-012';

  static const List<PortfolioServiceItem> services = <PortfolioServiceItem>[
    PortfolioServiceItem(
      id: 'registration',
      title: 'Pendaftaran Poli',
      subtitle: 'Pilih layanan dan jadwal kunjungan.',
      metric: '12 poli demo',
    ),
    PortfolioServiceItem(
      id: 'schedule',
      title: 'Jadwal Layanan',
      subtitle: 'Lihat waktu praktik yang tersedia.',
      metric: '8 jadwal',
    ),
    PortfolioServiceItem(
      id: 'rooms',
      title: 'Ketersediaan Kamar',
      subtitle: 'Ringkasan kapasitas tanpa data pasien.',
      metric: '6 tersedia',
    ),
    PortfolioServiceItem(
      id: 'cost',
      title: 'Informasi Tarif',
      subtitle: 'Estimasi layanan untuk simulasi.',
      metric: 'Data contoh',
    ),
  ];

  static const List<PortfolioMedicalResult> medicalResults =
      <PortfolioMedicalResult>[
        PortfolioMedicalResult(
          category: 'Laboratorium',
          title: 'Pemeriksaan Darah Rutin',
          subtitle: 'Ringkasan hasil contoh tersedia.',
          status: 'Selesai',
        ),
        PortfolioMedicalResult(
          category: 'Radiologi',
          title: 'Pemeriksaan Radiologi Demo',
          subtitle: 'Resume dan catatan contoh tersedia.',
          status: 'Terverifikasi',
        ),
        PortfolioMedicalResult(
          category: 'Resep',
          title: 'Resep Kunjungan Demo',
          subtitle: 'Satu resep sintetis siap dilihat.',
          status: 'Siap',
        ),
      ];

  static const List<PortfolioVisit> visits = <PortfolioVisit>[
    PortfolioVisit(
      date: '15 Juli 2026',
      service: 'Poli Umum Demo',
      summary: 'Kunjungan simulasi selesai dan resume tersedia.',
      status: 'Selesai',
    ),
    PortfolioVisit(
      date: '02 Juni 2026',
      service: 'Telekonsultasi Demo',
      summary: 'Konsultasi sintetis untuk demonstrasi alur.',
      status: 'Selesai',
    ),
  ];
}
