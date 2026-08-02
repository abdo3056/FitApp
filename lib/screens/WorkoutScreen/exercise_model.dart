class ExerciseModel {
  final String name;
  final String image;
  final String muscle;
  final String sets;
  final String description;
  final List<String> instructions;

  ExerciseModel({
    required this.name,
    required this.image,
    required this.muscle,
    required this.sets,
    required this.description,
    required this.instructions,
  });
}