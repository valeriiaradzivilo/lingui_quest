import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lingui_quest/data/firebase/firebase_options.dart';
import 'package:lingui_quest/main.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/start/di.dart';

void main() {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    init();
    // HiveDatabase.openBox();
  });

  group('test-sign-up', () {
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey(KeyConstants.avatarPortal)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey(KeyConstants.signInButton)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey(KeyConstants.noProfileYet)));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(ValueKey(KeyConstants.emailSignUpField)), 'test@zip.com');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(ValueKey(KeyConstants.passwordSignUpField)), 'test');
      await tester.pumpAndSettle();
      expect(tester.widget<LinButton>(find.byKey(ValueKey(KeyConstants.signUpButton))).isEnabled, isFalse);
    });
  });
}

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}
