import 'package:flutter/material.dart';

import '../../data/portfolio_demo_data.dart';
import '../widgets/portfolio_widgets.dart';

class PortfolioQueuePage extends StatelessWidget {
  const PortfolioQueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPageBody(
      key: const Key('portfolio-queue-page'),
      children: <Widget>[
        const PortfolioPageHeader(
          icon: Icons.confirmation_number_outlined,
          title: 'Booking & Antrian',
          subtitle: 'Simulasi alur pilih layanan hingga nomor antrian terbit.',
          trailing: PortfolioBadge(
            label: 'SIMULASI',
            icon: Icons.science_outlined,
            color: Color(0xFFD27616),
          ),
        ),
        const SizedBox(height: 16),
        const _BookingProgress(),
        const SizedBox(height: 14),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.event_note_outlined,
                      color: Color(0xFF246BCE),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ringkasan booking sintetis',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const PortfolioInfoRow(
                  icon: Icons.local_hospital_outlined,
                  label: 'Layanan',
                  value: PortfolioDemoData.bookingPolyclinic,
                ),
                const SizedBox(height: 10),
                const PortfolioInfoRow(
                  icon: Icons.medical_services_outlined,
                  label: 'Tenaga medis',
                  value: PortfolioDemoData.bookingDoctor,
                ),
                const SizedBox(height: 10),
                const PortfolioInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Tanggal dan waktu',
                  value:
                      '${PortfolioDemoData.bookingDate} • ${PortfolioDemoData.bookingTime}',
                ),
                const SizedBox(height: 10),
                const PortfolioInfoRow(
                  icon: Icons.badge_outlined,
                  label: 'Identitas demo',
                  value:
                      '${PortfolioDemoData.patientName} • ${PortfolioDemoData.patientId}',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        const _QueueTicket(),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showOfflineMessage(context),
                icon: const Icon(Icons.edit_calendar_outlined),
                label: const Text('Ubah simulasi'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _showOfflineMessage(context),
                icon: const Icon(Icons.qr_code_rounded),
                label: const Text('Detail antrian'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showOfflineMessage(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Aksi simulasi tetap lokal dan tidak mengirim data.'),
        ),
      );
  }
}

class _BookingProgress extends StatelessWidget {
  const _BookingProgress();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: <Widget>[
            const _ProgressStep(number: '1', label: 'Layanan'),
            _ProgressLine(color: Theme.of(context).colorScheme.primary),
            const _ProgressStep(number: '2', label: 'Jadwal'),
            _ProgressLine(color: Theme.of(context).colorScheme.primary),
            const _ProgressStep(number: '3', label: 'Antrian'),
          ],
        ),
      ),
    );
  }
}

class _ProgressStep extends StatelessWidget {
  const _ProgressStep({required this.number, required this.label});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF246BCE),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF435168),
          ),
        ),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        margin: const EdgeInsets.only(left: 6, right: 6, bottom: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class _QueueTicket extends StatelessWidget {
  const _QueueTicket();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF0F766E), Color(0xFF1B9A88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NOMOR ANTRIAN DEMO',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  PortfolioDemoData.queueNumber,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _TicketPill(label: 'Menunggu'),
                    _TicketPill(label: '3 antrean lagi'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.qr_code_2_rounded,
              size: 58,
              color: Color(0xFF0F766E),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketPill extends StatelessWidget {
  const _TicketPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
