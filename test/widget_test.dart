import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ml_club_companion/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app opens a usable learning dashboard', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const CompanionApp());
    await tester.pumpAndSettle();
    expect(find.text('ML Club Companion'), findsOneWidget);
    expect(find.text('Make sense of\nintelligent systems.'), findsOneWidget);
  });
}
