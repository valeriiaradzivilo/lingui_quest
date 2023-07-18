import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingui_quest/main.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('test-sign-up', () {
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      // await Firebase.initializeApp();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('avatarIcon')));
      await tester.enterText(
          find.byKey(const ValueKey('emailSignUpField')), 'test@zip.com');
      await tester.enterText(
          find.byKey(const ValueKey('passwordSignUpField')), 'test');
      await addDelay(10);
      expect(
          tester
              .widget<LinMainButton>(find.byKey(const ValueKey('signUpButton')))
              .isEnabled,
          isFalse);
    });
  });
}

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}
