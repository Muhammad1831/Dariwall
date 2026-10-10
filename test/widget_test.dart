// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dariwall/features/welcome/presentation/page/welcome_page.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/style/app_theme_style.dart';
import 'package:flutter/services.dart';

void main() {
  testWidgets('real mobile welcome screen offers the two wallet entry flows', (WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final font = FontLoader('IRANSansWeb')..addFont(rootBundle.load('assets/fonts/IRANSANSWEB.ttf'));
    await font.load();
    await tester.pumpWidget(MaterialApp(theme: darkTheme, home: const Directionality(
      textDirection: TextDirection.rtl, child: WelcomePage())));
    await tester.pumpAndSettle();
    expect(find.text(AppString.createNewWallet), findsOneWidget);
    expect(find.text(AppString.haveWallet), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
