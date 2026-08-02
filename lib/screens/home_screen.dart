import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fitapp/screens/Nutrition_Screen/nutrition_screen.dart';
import 'package:fitapp/screens/WorkoutScreen/workout_screen.dart';
import 'package:fitapp/screens/bmi_calculator_screen.dart';
import 'package:fitapp/services/auth_service.dart';
import 'package:fitapp/services/firestore_sercive.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int currentIndex = 0;
    final user = AuthService().currentUser;
    Map<String, dynamic>? userData;
    bool isLoading = true;
    double percent = 0;

    double waterConsumed = 0;
    double waterGoal = 1;
    double waterPercent = 0;

    String get username => userData?['username'] ?? 'User';
    List<double> weightHistory = [];

    
@override
void initState() {
  super.initState();
  loadUser();
}

void loadUser() {
  if (user == null) return;

  final uid = user!.uid;

  FirestoreService()
      .getUserStream(uid)
      .listen((doc) {
    final data = doc.data();

    if (!mounted) return;

    final consumed = (data?['caloriesConsumed'] ?? 0).toDouble();
    final goal = (data?['caloriesGoal'] ?? 2000).toDouble();

    final waterConsumedVal =
        (data?['waterConsumed'] ?? 0).toDouble();

    final waterGoalVal =
        (data?['waterGoal'] ?? 1).toDouble();

    final weights = (data?['weightHistory'] ?? []) as List;

    setState(() {
      userData = data;
      isLoading = false;

      percent = (consumed / goal).clamp(0.0, 1.0);

      waterConsumed = waterConsumedVal;
      waterGoal = waterGoalVal;
      waterPercent =
          (waterConsumedVal / waterGoalVal).clamp(0.0, 1.0);

      weightHistory =
          weights.map((e) => (e as num).toDouble()).toList();
    });
  });
}
  Widget build(BuildContext context) {

    Widget _weightPoint(String value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFF6233D7),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey.shade300,
            ),
          ],
        );
      }

      Widget _actionButton(
        IconData icon,
        String text,
      ) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F2FF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: const Color(0xFF6233D7),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }
      if (isLoading) {
      return Scaffold(
          body: Center(child: CircularProgressIndicator()),
          );
        }
    var icon = Icons.play_arrow;
    var icon2 = Icons.restaurant;
    var icon3 = Icons.monitor_weight;
    var icon4 = Icons.refresh;
    return Scaffold(

       
      body : SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyRichText(
                        'Welcome Back, \n $username',
                        defaultStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: username,
                            style: TextStyle(fontSize: 30)
                          )
                        ],
                        ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.20,
                  width: MediaQuery.of(context).size.width*.9,
                  child: Card(
                    color: Color(0xFF6233D7).withOpacity(.8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Calories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),),
                          Row(
                            children: [
                              Text("${userData?['caloriesConsumed']?.toInt() ?? 0} / ${userData?['caloriesGoal']?.toInt() ?? 2000}",
                              style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                              SizedBox(width: 80,),
                              CircularPercentIndicator(
                                radius: 40,
                                lineWidth: 8,
                                percent: percent,
                                progressColor: Colors.white,
                                backgroundColor: Colors.white38,
                                center: Text('${(percent * 100).toInt()}%',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),                           
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          LinearPercentIndicator(
                            lineHeight: 10,
                            percent: percent,
                            width: MediaQuery.of(context).size.width*.8,
                            progressColor: Colors.white,
                            backgroundColor: Colors.white38,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.15),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Water",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "${waterConsumed.toInt()} / ${waterGoal.toInt()}",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.water_drop,
                                      color: Colors.lightBlue,
                                      size: 35,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Glasses",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                LinearProgressIndicator(
                                  value: waterPercent.clamp(0.0, 1.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
        
                      const SizedBox(width: 15),
        
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.15),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Workout",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.fitness_center,
                                  color: Color(0xFF6233D7),
                                  size: 30,
                                ),
                                Text(
                                  "Push Day",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Chest & Triceps",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 10),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.15),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Weight Progress",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
        
                        const SizedBox(height: 15),
        
                        Text(
                          weightHistory.isNotEmpty
                              ? weightHistory.last.toStringAsFixed(0)
                              : '0',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
        
                        const Text(
                          "Current Weight",
                          style: TextStyle(color: Colors.grey),
                        ),
        
                        const SizedBox(height: 20),
        
                        SizedBox(
                          height: 120,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            children: [
                              ...weightHistory.map((w) => _weightPoint(w.toInt().toString())).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        
                const SizedBox(height: 20),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
        
                      const SizedBox(height: 15),
        
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WorkoutScreen())),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      icon,
                                      color: const Color(0xFF6233D7),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Start Workout",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
        
                          const SizedBox(width: 10),
        
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NutritionScreen())),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.grey.shade900
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        icon2,
                                        color: const Color(0xFF6233D7),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Add Meal",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                          ),
        
                          const SizedBox(width: 10),
        
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BmiCalculatorScreen())),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade900
                                  : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      icon3,
                                      color: const Color(0xFF6233D7),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Calculate BMI",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final confirm = await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Reset Day?"),
                                    content: const Text("Are you sure you want to clear today's data?"),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Reset")),
                                    ],
                                  ),
                                );
                            
                                if (confirm == true) {
                                  await FirestoreService().resetDailyData(user!.uid);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.grey.shade900
                                        : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      icon4,
                                      color: const Color(0xFF6233D7),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Reset Day",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        )
      );
  }
}