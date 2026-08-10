import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'portfolio_profile_page.dart';
import 'portfolio_queue_page.dart';
import 'portfolio_records_page.dart';
import 'portfolio_services_page.dart';

class PortfolioShellPage extends StatefulWidget {
  const PortfolioShellPage({super.key});

  @override
  State<PortfolioShellPage> createState() => _PortfolioShellPageState();
}

class _PortfolioShellPageState extends State<PortfolioShellPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    PortfolioServicesPage(),
    PortfolioQueuePage(),
    PortfolioRecordsPage(),
    PortfolioProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const PortfolioWatermark(),
              Expanded(
                child: IndexedStack(index: _selectedIndex, children: _pages),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() => _selectedIndex = index);
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              key: Key('portfolio-services-tab'),
              icon: Icon(Icons.grid_view_rounded),
              selectedIcon: Icon(Icons.grid_view_rounded),
              label: 'Layanan',
            ),
            NavigationDestination(
              key: Key('portfolio-queue-tab'),
              icon: Icon(Icons.confirmation_number_outlined),
              selectedIcon: Icon(Icons.confirmation_number_rounded),
              label: 'Antrian',
            ),
            NavigationDestination(
              key: Key('portfolio-records-tab'),
              icon: Icon(Icons.folder_copy_outlined),
              selectedIcon: Icon(Icons.folder_copy_rounded),
              label: 'Rekam',
            ),
            NavigationDestination(
              key: Key('portfolio-profile-tab'),
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioWatermark extends StatelessWidget {
  const PortfolioWatermark({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Mode portofolio dengan data sintetis dan tanpa jaringan',
      child: Container(
        key: const Key('portfolio-watermark'),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF4D8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF2C864)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.shield_outlined, size: 16, color: Color(0xFF7A5510)),
            SizedBox(width: 7),
            Flexible(
              child: Text(
                'PORTOFOLIO • DATA SINTETIS • OFFLINE',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF694807),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
