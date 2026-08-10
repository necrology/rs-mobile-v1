import 'package:flutter/material.dart';

import '../../data/portfolio_demo_data.dart';
import '../widgets/portfolio_widgets.dart';

class PortfolioRecordsPage extends StatelessWidget {
  const PortfolioRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPageBody(
      key: const Key('portfolio-records-page'),
      children: <Widget>[
        const PortfolioPageHeader(
          icon: Icons.folder_copy_outlined,
          title: 'Hasil & Rekam Medis',
          subtitle: 'Ringkasan hasil klinis sintetis dalam satu timeline.',
          trailing: PortfolioBadge(
            label: PortfolioDemoData.patientId,
            icon: Icons.badge_outlined,
            color: Color(0xFF6C4CCF),
          ),
        ),
        const SizedBox(height: 16),
        const _RecordsHero(),
        const SizedBox(height: 16),
        const PortfolioSectionTitle(
          title: 'Hasil terbaru',
          subtitle: 'Tidak ada nilai medis atau identitas pasien nyata.',
        ),
        const SizedBox(height: 10),
        ...PortfolioDemoData.medicalResults.map(
          (PortfolioMedicalResult result) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ResultCard(result: result),
          ),
        ),
        const _ClinicalNotice(),
      ],
    );
  }
}

class _RecordsHero extends StatelessWidget {
  const _RecordsHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF4B35A6), Color(0xFF7659D6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const _SyncedBadge(),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '3 hasil demo tersedia',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Contoh pengelompokan laboratorium, radiologi, dan resep setelah kunjungan.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _RecordMetric(label: 'Lab', value: '1'),
              _RecordMetric(label: 'Radiologi', value: '1'),
              _RecordMetric(label: 'Resep', value: '1'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SyncedBadge extends StatelessWidget {
  const _SyncedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.offline_pin_outlined, size: 14, color: Colors.white),
          SizedBox(width: 5),
          Text(
            'Snapshot lokal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordMetric extends StatelessWidget {
  const _RecordMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        '$label  $value',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final PortfolioMedicalResult result;

  @override
  Widget build(BuildContext context) {
    final (IconData, Color) visual = switch (result.category) {
      'Laboratorium' => (Icons.science_outlined, const Color(0xFF198B67)),
      'Radiologi' => (Icons.monitor_heart_outlined, const Color(0xFF246BCE)),
      _ => (Icons.medication_outlined, const Color(0xFFD27616)),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: visual.$2.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(visual.$1, color: visual.$2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          result.category.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: visual.$2,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.45,
                              ),
                        ),
                      ),
                      PortfolioBadge(label: result.status, color: visual.$2),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    result.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6A778A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClinicalNotice extends StatelessWidget {
  const _ClinicalNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFF1D79D)),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.info_outline_rounded, color: Color(0xFF94630B)),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Konten klinis ini hanya menunjukkan struktur antarmuka.',
              style: TextStyle(
                color: Color(0xFF76520E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
