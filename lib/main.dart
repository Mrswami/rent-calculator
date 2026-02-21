import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'utils/app_router.dart';
import 'services/firebase_service.dart';
import 'services/user_setup_service.dart';

import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDrhe_jNTXrGF1xiclVPXWAuztRAglGXuM',
        appId: '1:707294763198:web:d89c51bb2f52beeffe66ef',
        messagingSenderId: '707294763198',
        projectId: 'rent-calculator-bedd3',
        authDomain: 'rent-calculator-bedd3.firebaseapp.com',
        storageBucket: 'rent-calculator-bedd3.firebasestorage.app',
      ),
    );

    // Create Jacob, Nico & Eddy accounts if they don't exist yet
    await UserSetupService.createDefaultUsersIfNeeded();
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  runApp(const RentCalculatorApp());
}

class RentCalculatorApp extends StatefulWidget {
  final FirebaseService? firebaseService;
  const RentCalculatorApp({super.key, this.firebaseService});

  @override
  State<RentCalculatorApp> createState() => _RentCalculatorAppState();
}

class _RentCalculatorAppState extends State<RentCalculatorApp> {
  late final FirebaseService _firebaseService;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Use provided service (e.g. for testing) or create default
    _firebaseService = widget.firebaseService ?? FirebaseService();
    _router = AppRouter.createRouter(_firebaseService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseService>.value(value: _firebaseService),
      ],
      child: MaterialApp.router(
        title: 'Rent Calculator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}
