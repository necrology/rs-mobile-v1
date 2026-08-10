import 'package:flutter/material.dart';

import '../../data/portfolio_demo_data.dart';
import '../widgets/portfolio_widgets.dart';

class PortfolioProfilePage extends StatelessWidget {
  const PortfolioProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPageBody(
      key: const Key('portfolio-profile-page'),
      children: <Widget>[
        const PortfolioPageHeader(
          icon: Icons.person_outline_rounded,
          title: 'Profil & Riwayat',
          subtitle: 'Identitas dan kunjungan sintetis untuk alur portofolio.',
          trailing: PortfolioBadge(
            label: 'LOKAL',
            icon: Icons.phonelink_lock_outlined,
            color: Color(0xFF0F766E),
          ),
        ),
        const SizedBox(height: 16),
        const _ProfileHero(),
        const SizedBox(height: 16),
        const PortfolioSectionTitle(
          title: 'Riwayat kunjungan',
          subtitle: 'Timeline di bawah tidak berasal dari sistem rumah sakit.',
        ),
        const SizedBox(height: 10),
        ...PortfolioDemoData.visits.asMap().entries.map(
          (MapEntry<int, PortfolioVisit> entry) => _VisitTimelineItem(
            visit: entry.value,
            isLast: entry.key == PortfolioDemoData.visits.length - 1,
          ),
        ),
        const SizedBox(height: 4),
        const _PrivacyCard(),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF0F6D69), Color(0xFF2D938D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF0F6D69),
                  size: 36,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      PortfolioDemoData.patientName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      PortfolioDemoData.patientId,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const _ProfileStatus(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: <Widget>[
                const _ProfileField(
                  icon: Icons.alternate_email_rounded,
                  label: 'Email sintetis',
                  value: PortfolioDemoData.patientEmail,
                ),
                Divider(color: Colors.white.withValues(alpha: 0.16)),
                const _ProfileField(
                  icon: Icons.security_outlined,
                  label: 'Penyimpanan',
                  value: 'Tidak disimpan • sesi statis',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatus extends StatelessWidget {
  const _ProfileStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.verified_outlined, size: 14, color: Colors.white),
          SizedBox(width: 5),
          Text(
            'Akun demo terverifikasi',
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

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VisitTimelineItem extends StatelessWidget {
  const _VisitTimelineItem({required this.visit, required this.isLast});

  final PortfolioVisit visit;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: 28,
            child: Column(
              children: <Widget>[
                Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    color: Color(0xFF246BCE),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: const Color(0xFFC9D7E8)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              visit.service,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                          PortfolioBadge(
                            label: visit.status,
                            color: const Color(0xFF198B67),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        visit.date,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: const Color(0xFF246BCE),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        visit.summary,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF6A778A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFC9DEF7)),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.privacy_tip_outlined, color: Color(0xFF1E5FAD)),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Mode portofolio tidak membaca secure storage aplikasi normal.',
              style: TextStyle(
                color: Color(0xFF194E8D),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
