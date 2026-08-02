import 'package:fitapp/screens/WorkoutScreen/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitapp/screens/WorkoutScreen/exercise_data.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final exercises = workoutData[category]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (_, index) {
          final exercise = exercises[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: Image.network(
                  exercise.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(exercise.name),
              trailing:
                  const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ExerciseDetailsScreen(
                      exercise: exercise,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}




// child: Container(
//   width: 60,
//   height: 60,
//   color: Colors.grey.shade300,
//   child: const Icon(Icons.fitness_center),
// )