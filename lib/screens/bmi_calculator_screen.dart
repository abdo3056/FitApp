import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:fitapp/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  double height = 180;
  double weight = 75;
  double bmiResult = 23.1;

  @override
  void initState() {
    super.initState();
    _calculateBmi();
  }

  void _calculateBmi() async {
    setState(() {
      bmiResult = weight / pow(height / 100, 2);
    });

    // Save to Firestore
    final user = AuthService().currentUser;
    if (user != null) {
      await FirestoreService().saveUserData(
        uid: user.uid,
        data: {
          'weight': weight.toInt(),
          'height': height.toInt(),
          'weightHistory': FieldValue.arrayUnion([weight.toDouble()]),
        },
      );
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Data saved successfully!")),
      //   );
      // }
    }
  }

  String _getBmiStatus() {
    if (bmiResult < 18.5) return "Underweight";
    if (bmiResult >= 18.5 && bmiResult <= 24.9) return "Normal Weight";
    if (bmiResult >= 25 && bmiResult <= 29.9) return "Overweight";
    return "Obese";
  }

  Color _getBmiColor() {
    if (bmiResult < 18.5) return Colors.blueGrey;
    if (bmiResult >= 18.5 && bmiResult <= 24.9) return Colors.green;
    if (bmiResult >= 25 && bmiResult <= 29.9) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
        ),
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                // Height Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Height",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${height.toInt()} ",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "cm",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: const Color(0xFF6233D7),
                          inactiveTrackColor: const Color(0xFFF0E5FF),
                          thumbColor: const Color(0xFF6233D7),
                          overlayColor: const Color(0xFF6233D7).withAlpha(30),
                          trackHeight: 4,
                          trackShape: const RoundedRectSliderTrackShape(),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                        ),
                        child: Slider(
                          value: height,
                          min: 100,
                          max: 250,
                          onChanged: (value) {
                            setState(() {
                              height = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Weight",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${weight.toInt()} ",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "kg",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: const Color(0xFF6233D7),
                          inactiveTrackColor: const Color(0xFFF0E5FF),
                          thumbColor: const Color(0xFF6233D7),
                          overlayColor: const Color(0xFF6233D7).withAlpha(30),
                          trackHeight: 4,
                          trackShape: const RoundedRectSliderTrackShape(),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                        ),
                        child: Slider(
                          value: weight,
                          min: 30,
                          max: 150,
                          onChanged: (value) {
                            setState(() {
                              weight = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _calculateBmi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6233D7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                _buildCard(
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Your BMI",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          bmiResult.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _getBmiStatus(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getBmiColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _buildCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem(
                        "< 18.5",
                        "Underweight",
                        bmiResult < 18.5 ? Colors.blueGrey : Colors.grey,
                      ),
                      _buildLegendItem(
                        "18.5 - 24.9",
                        "Normal",
                        bmiResult >= 18.5 && bmiResult <= 24.9
                            ? Colors.green
                            : Colors.grey,
                      ),
                      _buildLegendItem(
                        "25 - 29.9",
                        "Overweight",
                        bmiResult >= 25 && bmiResult <= 29.9
                            ? Colors.orange
                            : Colors.grey,
                      ),
                      _buildLegendItem(
                        "30+",
                        "Obese",
                        bmiResult >= 30 ? Colors.red : Colors.grey,
                      ),
                    ],
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

  Widget _buildCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildLegendItem(String range, String label, Color color) {
    return Column(
      children: [
        Text(
          range,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}