import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rs_mobile_otista_v1_0/app.dart';
import 'package:rs_mobile_otista_v1_0/features/portfolio/data/portfolio_demo_data.dart';
import 'package:rs_mobile_otista_v1_0/features/portfolio/presentation/portfolio_app.dart';

void main() {
  const bool portfolioModeEnabled = bool.fromEnvironment(
    'PORTFOLIO_MODE',
    defaultValue: false,
  );

  testWidgets(
    'RsMobileApp returns portfolio shell before normal providers',
    (WidgetTester tester) async {
      await tester.pumpWidget(const RsMobileApp());
      await tester.pump();

      expect(find.byKey(const Key('portfolio-watermark')), findsOneWidget);
      expect(find.text('Portal Pasien Demo'), findsOneWidget);
    },
    skip: !portfolioModeEnabled,
  );

  testWidgets('portfolio shell exposes four offline synthetic workflows', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.byKey(const Key('portfolio-watermark')), findsOneWidget);
    expect(find.text('PORTOFOLIO • DATA SINTETIS • OFFLINE'), findsOneWidget);
    expect(find.byKey(const Key('portfolio-services-page')), findsOneWidget);
    expect(find.text('Portal Pasien Demo'), findsOneWidget);

    await tester.tap(find.byKey(const Key('portfolio-queue-tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('portfolio-queue-page')), findsOneWidget);
    expect(find.text(PortfolioDemoData.queueNumber), findsOneWidget);

    await tester.tap(find.byKey(const Key('portfolio-records-tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('portfolio-records-page')), findsOneWidget);
    expect(find.text('Hasil & Rekam Medis'), findsOneWidget);

    await tester.tap(find.byKey(const Key('portfolio-profile-tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('portfolio-profile-page')), findsOneWidget);
    expect(find.text(PortfolioDemoData.patientName), findsOneWidget);
    expect(find.text(PortfolioDemoData.patientEmail), findsOneWidget);

    expect(find.textContaining('RSUD'), findsNothing);
    expect(find.textContaining('Otista'), findsNothing);
  });

  test(
    'portfolio identity is visibly synthetic and uses a reserved domain',
    () {
      expect(PortfolioDemoData.patientId, startsWith('DEMO-'));
      expect(PortfolioDemoData.patientEmail, endsWith('.invalid'));
      expect(PortfolioDemoData.patientName.toLowerCase(), contains('demo'));
    },
  );
}
