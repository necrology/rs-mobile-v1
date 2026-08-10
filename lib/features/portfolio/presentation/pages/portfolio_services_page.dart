import 'package:flutter/material.dart';

import '../../data/portfolio_demo_data.dart';
import '../widgets/portfolio_widgets.dart';

class PortfolioServicesPage extends StatelessWidget {
  const PortfolioServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPageBody(
      key: const Key('portfolio-services-page'),
      children: <Widget>[
        const PortfolioPageHeader(
          icon: Icons.health_and_safety_outlined,
          title: 'Layanan Pasien',
          subtitle: 'Satu pintu layanan rumah sakit untuk demonstrasi produk.',
          trailing: PortfolioBadge(
            label: 'DEMO',
            icon: Icons.offline_bolt_outlined,
          ),
        ),
        const SizedBox(height: 16),
        const _ServicesHero(),
        const SizedBox(height: 18),
        const PortfolioSectionTitle(
          title: 'Layanan utama',
          subtitle: 'Seluruh angka dan status di bawah adalah data sintetis.',
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: PortfolioDemoData.services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.08,
          ),
          itemBuilder: (BuildContext context, int index) {
            final PortfolioServiceItem service =
                PortfolioDemoData.services[index];
            return _ServiceCard(service: service);
          },
        ),
        const SizedBox(height: 14),
        const _OfflineNotice(),
      ],
    );
  }
}

class _ServicesHero extends StatelessWidget {
  const _ServicesHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF174F9E), Color(0xFF3E7FD8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF174F9E).withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.local_hospital_outlined,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const Icon(Icons.lock_outline_rounded, color: Colors.white),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Portal Pasien Demo',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Jelajahi alur layanan tanpa akun, API, atau data rumah sakit nyata.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.90),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _HeroMetric(icon: Icons.apartment_rounded, label: '12 poli demo'),
              _HeroMetric(icon: Icons.schedule_rounded, label: 'Layanan 24/7'),
              _HeroMetric(icon: Icons.bed_outlined, label: '6 kamar tersedia'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final PortfolioServiceItem service;

  @override
  Widget build(BuildContext context) {
    final (IconData, Color) visual = switch (service.id) {
      'registration' => (
        Icons.event_available_outlined,
        const Color(0xFF246BCE),
      ),
      'schedule' => (Icons.calendar_month_outlined, const Color(0xFF6C4CCF)),
      'rooms' => (Icons.bed_outlined, const Color(0xFF198B67)),
      _ => (Icons.receipt_long_outlined, const Color(0xFFD27616)),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: visual.$2.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(visual.$1, color: visual.$2, size: 22),
            ),
            const Spacer(),
            Text(
              service.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF223248),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              service.metric,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: visual.$2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineNotice extends StatelessWidget {
  const _OfflineNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBFE6D6)),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.cloud_off_outlined, color: Color(0xFF197255)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Mode ini tidak membuat koneksi jaringan atau menyimpan sesi.',
              style: TextStyle(
                color: Color(0xFF165A45),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
