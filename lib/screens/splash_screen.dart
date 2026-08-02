import 'package:fitapp/screens/home_screen.dart';
import 'package:fitapp/screens/landing_page.dart';
import 'package:fitapp/screens/onboarding_screen.dart';
import 'package:fitapp/screens/user_info_screen.dart';
import 'package:fitapp/services/auth_service.dart';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  static const String _onboardingKey = 'onboardingDone';
  static const String _loggedInKey = 'isLoggedIn';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    Future.delayed(const Duration(seconds: 3), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool(_onboardingKey) ?? false;

    if (!onboardingDone) {
      _replaceWith(const OnboardingScreen());
      return;
    }

    final hasActiveSession = prefs.getBool(_loggedInKey) ?? false;
    final user = AuthService().currentUser;

    if (user == null || !hasActiveSession) {
      if (user != null && !hasActiveSession) {
        await AuthService().signOut();
      }
      if (!mounted) return;
      _replaceWith(const LandingPage());
      return;
    }

    try {
      final doc = await FirestoreService().getUserData(user.uid);
      final data = doc.data();
      final profileCompleted = FirestoreService.isProfileComplete(data);

      if (!mounted) return;
      if (profileCompleted) {
        _replaceWith(const HomeScreen());
      } else {
        _replaceWith(UserInfoScreen(
          username: data?['username']?.toString(),
          email: data?['email']?.toString() ?? user.email,
        ));
      }
    } catch (_) {
      if (!mounted) return;
      _replaceWith(const LandingPage());
    }
  }

  void _replaceWith(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6233D7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Icon(
                  Icons.fitness_center,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Gym mate",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
            const SizedBox(height: 15),
            const Text(
              "Loading your journey...",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
