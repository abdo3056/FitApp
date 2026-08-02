class CalorieService {

  static double calculateBMR({
    required double weight,
    required double height,
    required int age,
    required String gender,
  }) {

    if (gender == 'Male') {
      return (10 * weight) +
          (6.25 * height) -
          (5 * age) +
          5;
    }

    return (10 * weight) +
        (6.25 * height) -
        (5 * age) -
        161;
  }

  static double calculateCaloriesGoal({
    required double bmr,
    required String goal,
  }) {

    switch (goal) {
      case 'Lose Weight':
        return bmr * 1.55 - 500;

      case 'Gain Weight':
        return bmr * 1.55 + 500;

      case 'Gain Muscle':
        return bmr * 1.55 + 250;

      default:
        return bmr * 1.55;
    }
  }
}