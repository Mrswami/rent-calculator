import 'package:flutter_test/flutter_test.dart';
import 'package:rent_calculator/main.dart';
import 'package:rent_calculator/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Manual stub to avoid dependency on mockito or real Firebase
class MockFirebaseService implements FirebaseService {
  @override
  User? get currentUser => null;

  @override
  Stream<User?> get authStateChanges => const Stream.empty();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app with the mocked service.
    await tester.pumpWidget(
      RentCalculatorApp(firebaseService: MockFirebaseService()),
    );

    // Give it a frame to render the initial location
    await tester.pump();

    // Verify that the title is present on the login screen
    expect(find.text('Rent Calculator'), findsWidgets);
  });
}
