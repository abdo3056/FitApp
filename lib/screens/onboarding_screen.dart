import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fitapp/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingDone', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _buildPage(
          image: 'assets/images/track_workout.jpg',
          title: 'Track Workouts \n Get Stronger',
          highlighted: 'Stronger',
          body: 'Track Your Workouts, monitor \n progress, and achieve your \n fitness goals step by step',
        ),
        _buildPage(
          image: 'assets/images/track_progress.jpg',
          title: 'Track Progress \n See Results',
          highlighted: 'Results',
          body: 'Track body measurments, photos \n and stats. Visualize your progress \n and stay motivated.',
        ),
        _buildPage(
          image: 'assets/images/nutrition.jpg',
          title: 'Track Nutrition \n Eat Better',
          highlighted: 'Better',
          body: 'Track calories, macros, and nutrients \n build easy eating habits \n that fit your lifestyle.',
        ),
      ],
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontSize: 20, color: Colors.white)),
      onSkip: () => _finishOnboarding(),
      showNextButton: false,
      showDoneButton: true,
      done: const Text('Done', style: TextStyle(fontSize: 20, color: Colors.white)),
      onDone: () => _finishOnboarding(),
    );
  }

  PageViewModel _buildPage({
    required String image,
    required String title,
    required String highlighted,
    required String body,
  }) {
    return PageViewModel(
      titleWidget: const SizedBox(),
      bodyWidget: const SizedBox(),
      decoration: const PageDecoration(
        fullScreen: true,
        bodyFlex: 0,
        contentMargin: EdgeInsets.zero,
        bodyPadding: EdgeInsets.zero,
        imagePadding: EdgeInsets.zero,
      ),
      image: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                EasyRichText(
                  title,
                  defaultStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: highlighted,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  body,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
