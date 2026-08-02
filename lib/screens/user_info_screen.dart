import 'package:fitapp/blocs/auth/auth_bloc.dart';
import 'package:fitapp/screens/home_screen.dart';
import 'package:fitapp/screens/main_screen.dart';
import 'package:fitapp/services/auth_service.dart';
import 'package:fitapp/services/calorie_service.dart';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:fitapp/widgets/choice_clip.dart';
import 'package:fitapp/widgets/info_field.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  final String? username;
  final String? email;

  const UserInfoScreen({super.key, this.username, this.email});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String selectedGender = '';
  String selectedGoal = '';
  bool isLoading = false;

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us about yourself',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This helps us personalize\nyour experience',
                  style: TextStyle(fontSize: 16, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 50),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C63FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                UserInfoField(
                  label: 'Age',
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter Your Age';
                    final age = int.tryParse(value);
                    if (age == null) return 'Age must be a number';
                    if (age <= 17 || age > 100) return 'Enter Your Real Age';
                    return null;
                  },
                  width: double.infinity,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: UserInfoField(
                        label: 'Height (cm)',
                        controller: heightController,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Enter Your Height';
                          final h = int.tryParse(value);
                          if (h == null) return 'Height must be a number';
                          if (h <= 100 || h > 250)
                            return 'Enter valid height';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UserInfoField(
                        label: 'Weight (kg)',
                        controller: weightController,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Enter Your Weight';
                          final w = int.tryParse(value);
                          if (w == null) return 'Weight must be a number';
                          if (w <= 30 || w > 200)
                            return 'Enter valid weight';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'Gender',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomChoiceChip(
                        text: 'Male',
                        isSelected: selectedGender == 'Male',
                        isDark: isDark,
                        onTap: () => setState(() => selectedGender = 'Male'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomChoiceChip(
                        text: 'Female',
                        isSelected: selectedGender == 'Female',
                        isDark: isDark,
                        onTap: () => setState(() => selectedGender = 'Female'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'Your Goal',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    'Lose Weight',
                    'Maintain Weight',
                    'Gain Weight',
                    'Gain Muscle',
                  ]
                      .map((goal) => CustomChoiceChip(
                            text: goal,
                            isSelected: selectedGoal == goal,
                            isDark: isDark,
                            onTap: () => setState(() => selectedGoal = goal),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: isLoading ? null : _onContinue,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedGender.isEmpty || selectedGoal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select gender and goal')),
      );
      return;
    }

    setState(() => isLoading = true);

    final user = AuthService().currentUser;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    final age = int.parse(ageController.text);
    final height = double.parse(heightController.text);
    final weight = double.parse(weightController.text);

    final bmr = CalorieService.calculateBMR(
      weight: weight,
      height: height,
      age: age,
      gender: selectedGender,
    );

    final caloriesGoal = CalorieService.calculateCaloriesGoal(
      bmr: bmr,
      goal: selectedGoal,
    );

    await FirestoreService().saveUserData(
      uid: user.uid,
      data: {
        'profileCompleted': true,
        'age': age,
        'height': height,
        'weight': weight,
        'gender': selectedGender,
        'goal': selectedGoal,
        'caloriesGoal': caloriesGoal,
        'caloriesConsumed': 0,
        'waterConsumed': 0,
        'waterGoal': 8,
        'username': widget.username ?? user.email?.split('@')[0] ?? 'User',
        'email': widget.email ?? user.email ?? '',
        'weightHistory': [weight],
      },
    );

    // Persist login so re-open goes to HomeScreen
    await AuthBloc.persistLogin();

    if (!mounted) return;
    setState(() => isLoading = false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }
}
