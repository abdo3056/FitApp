import 'package:fitapp/screens/WorkoutScreen/exercise_model.dart';

final Map<String, List<ExerciseModel>> workoutData = {
 "Chest": [
  ExerciseModel(
    name: "Incline Dumbbell Press",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Incline-Dumbbell-Press.gif",
    muscle: "Upper Chest",
    sets: "3 Sets × 10 Reps",
    description: "One of the best exercises for building the upper chest.",
    instructions: [
      "Adjust the bench to 30-45 degrees.",
      "Hold dumbbells at chest level.",
      "Press upward until arms are extended.",
      "Lower slowly under control."
    ],
  ),

  ExerciseModel(
    name: "Decline Dumbbell Press",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Press-1.gif",
    muscle: "Lower Chest",
    sets: "3 Sets × 10 Reps",
    description: "Targets the lower chest fibers.",
    instructions: [
      "Lie on a decline bench.",
      "Keep dumbbells over chest.",
      "Lower until stretch is felt.",
      "Press back up."
    ],
  ),

  ExerciseModel(
    name: "Pec Deck Fly",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/05/10301301-Lever-Pec-Deck-Fly_Chest_720.gif",
    muscle: "Chest",
    sets: "3 Sets × 10 Reps",
    description: "Isolation movement for chest development.",
    instructions: [
      "Sit with back against pad.",
      "Grip handles firmly.",
      "Bring handles together.",
      "Return slowly."
    ],
  ),

  ExerciseModel(
  name: "Bench Press",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Bench-Press.gif",
  muscle: "Chest",
  sets: "3 Sets × 8 Reps",
  description: "The king of chest exercises.",
  instructions: [
    "Lie flat on bench.",
    "Grip bar slightly wider than shoulders.",
    "Lower bar to chest.",
    "Press upward."
  ],
),

ExerciseModel(
  name: "Incline Barbell Press",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Incline-Barbell-Bench-Press.gif",
  muscle: "Upper Chest",
  sets: "3 Sets × 10 Reps",
  description: "Builds upper chest mass.",
  instructions: [
    "Set bench incline.",
    "Lower bar slowly.",
    "Press upward.",
    "Control the movement."
  ],
),

ExerciseModel(
  name: "Cable Fly",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Low-Cable-Crossover.gif",
  muscle: "Chest",
  sets: "3 Sets × 10 Reps",
  description: "Excellent chest isolation.",
  instructions: [
    "Stand between cables.",
    "Bring hands together.",
    "Squeeze chest.",
    "Return slowly."
  ],
),

ExerciseModel(
  name: "Chest Dips",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Chest-Dips.gif",
  muscle: "Lower Chest",
  sets: "3 Sets × 10 Reps",
  description: "Bodyweight chest exercise.",
  instructions: [
    "Lean forward.",
    "Lower body.",
    "Push upward.",
    "Lock out arms."
  ],
),

ExerciseModel(
  name: "Push Ups",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Push-Up.gif",
  muscle: "Chest",
  sets: "3 Sets × 20 Reps",
  description: "Classic bodyweight movement.",
  instructions: [
    "Keep body straight.",
    "Lower chest.",
    "Push up.",
    "Repeat."
  ],
),

],

  "Back": [
  ExerciseModel(
    name: "T-Bar Row",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/08/Lever-Reverse-T-Bar-Row.gif",
    muscle: "Middle Back",
    sets: "3 Sets × 10 Reps",
    description: "Builds thickness in the back.",
    instructions: [
      "Keep chest up.",
      "Pull weight toward torso.",
      "Squeeze shoulder blades.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Lat Pulldown",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Lat-Pulldown.gif",
    muscle: "Lats",
    sets: "3 Sets × 10 Reps",
    description: "Develops back width.",
    instructions: [
      "Use wide grip.",
      "Pull bar to upper chest.",
      "Pause briefly.",
      "Return slowly."
    ],
  ),

  ExerciseModel(
    name: "Seated Cable Row",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/close-grip-cable-row.gif",
    muscle: "Middle Back",
    sets: "3 Sets × 10 Reps",
    description: "Excellent for overall back development.",
    instructions: [
      "Sit upright.",
      "Pull handle toward waist.",
      "Squeeze shoulder blades.",
      "Extend arms slowly."
    ],
  ),

  ExerciseModel(
  name: "Pull Up",
  image: "https://fitnessprogramer.com/wp-content/uploads/2025/07/Top-Half-Pull-up.gif",
  muscle: "Lats",
  sets: "3 Sets × 8 Reps",
  description: "Best bodyweight back exercise.",
  instructions: [
    "Grab bar wide.",
    "Pull chest upward.",
    "Pause.",
    "Lower slowly."
  ],
),


ExerciseModel(
  name: "Straight Arm Pulldown",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Rope-Straight-Arm-Pulldown.gif",
  muscle: "Lats",
  sets: "3 Sets × 10 Reps",
  description: "Isolation for lats.",
  instructions: [
    "Keep arms straight.",
    "Pull cable down.",
    "Squeeze lats.",
    "Return slowly."
  ],
),

],

"Shoulders": [
  ExerciseModel(
    name: "Front Raise",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Alternating-Dumbbell-Front-Raise.gif",
    muscle: "Front Delts",
    sets: "3 Sets × 10 Reps",
    description: "Targets the front shoulder.",
    instructions: [
      "Raise dumbbells forward.",
      "Reach shoulder height.",
      "Pause briefly.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Lateral Raise",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Lateral-Raise.gif",
    muscle: "Side Delts",
    sets: "3 Sets × 15 Reps",
    description: "Builds shoulder width.",
    instructions: [
      "Raise arms sideways.",
      "Keep elbows slightly bent.",
      "Stop at shoulder level.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Rear Delt Fly",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Rear-Delt-Machine-Flys.gif",
    muscle: "Rear Delts",
    sets: "3 Sets × 15 Reps",
    description: "Targets rear shoulder muscles.",
    instructions: [
      "Bend at hips.",
      "Keep back flat.",
      "Raise arms outward.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
  name: "Shoulder Press",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Shoulder-Press.gif",
  muscle: "Shoulders",
  sets: "3 Sets × 10 Reps",
  description: "Mass builder for shoulders.",
  instructions: [
    "Press dumbbells upward.",
    "Lock out.",
    "Lower slowly.",
    "Repeat."
  ],
),

ExerciseModel(
  name: "Face Pull",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Face-Pull.gif",
  muscle: "Rear Delts",
  sets: "3 Sets × 15 Reps",
  description: "Improves posture and rear delts.",
  instructions: [
    "Pull rope to face.",
    "Spread hands apart.",
    "Pause.",
    "Return slowly."
  ],
),

ExerciseModel(
  name: "Upright Row",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Cable-Upright-Row.gif",
  muscle: "Traps & Delts",
  sets: "3 Sets × 10 Reps",
  description: "Targets shoulders and traps.",
  instructions: [
    "Pull bar upward.",
    "Lead with elbows.",
    "Reach chest level.",
    "Lower slowly."
  ],
),

],

"Arms": [
  ExerciseModel(
    name: "Barbell Curl",
    image: "https://fitnessprogramer.com/wp-content/uploads/2022/04/Double-Arm-Dumbbell-Curl.gif",
    muscle: "Biceps",
    sets: "3 Sets × 10 Reps",
    description: "Classic biceps builder.",
    instructions: [
      "Keep elbows fixed.",
      "Curl the bar upward.",
      "Squeeze biceps.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Hammer Curl",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Hammer-Curl.gif",
    muscle: "Biceps",
    sets: "3 Sets × 10 Reps",
    description: "Builds arm thickness.",
    instructions: [
      "Use neutral grip.",
      "Curl upward.",
      "Pause at top.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Tricep Pushdown",
    image: "https://fitnessprogramer.com/wp-content/uploads/2022/11/One-arm-triceps-pushdown.gif",
    muscle: "Triceps",
    sets: "3 Sets × 10 Reps",
    description: "Great isolation exercise.",
    instructions: [
      "Keep elbows tucked.",
      "Push rope downward.",
      "Fully extend arms.",
      "Return slowly."
    ],
  ),

  ExerciseModel(
  name: "EZ Bar Curl",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Z-Bar-Preacher-Curl.gif",
  muscle: "Biceps",
  sets: "4 Sets × 10 Reps",
  description: "Targets the biceps with reduced wrist strain.",
  instructions: [
    "Hold EZ bar with shoulder-width grip.",
    "Curl the weight upward.",
    "Squeeze biceps at the top.",
    "Lower slowly."
  ],
),

ExerciseModel(
  name: "Preacher Curl",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Dumbbell-Preacher-Curl.gif",
  muscle: "Biceps",
  sets: "3 Sets × 12 Reps",
  description: "Excellent isolation exercise for biceps.",
  instructions: [
    "Rest arms on preacher bench.",
    "Curl the weight upward.",
    "Pause at the top.",
    "Lower slowly."
  ],
),

ExerciseModel(
  name: "Cable Curl",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/cable-curl.gif",
  muscle: "Biceps",
  sets: "3 Sets × 12 Reps",
  description: "Provides constant tension on the biceps.",
  instructions: [
    "Attach straight bar to cable.",
    "Curl upward.",
    "Squeeze biceps.",
    "Return slowly."
  ],
),

ExerciseModel(
  name: "Concentration Curl",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Concentration-Curl.gif",
  muscle: "Biceps",
  sets: "3 Sets × 12 Reps",
  description: "Focuses on peak contraction.",
  instructions: [
    "Sit on bench.",
    "Rest elbow on inner thigh.",
    "Curl dumbbell upward.",
    "Lower slowly."
  ],
),


ExerciseModel(
  name: "Skull Crushers",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Dumbbell-Skull-Crusher.gif",
  muscle: "Triceps",
  sets: "4 Sets × 10 Reps",
  description: "Builds triceps mass.",
  instructions: [
    "Lie on bench.",
    "Lower bar toward forehead.",
    "Extend elbows.",
    "Repeat."
  ],
),


ExerciseModel(
  name: "Bench Dips",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Bench-Dips.gif",
  muscle: "Triceps",
  sets: "3 Sets × 15 Reps",
  description: "Bodyweight triceps exercise.",
  instructions: [
    "Place hands on bench.",
    "Lower body down.",
    "Push back up.",
    "Repeat."
  ],
),
],

  "Legs": [
  ExerciseModel(
    name: "Leg Press",
    image: "https://fitnessprogramer.com/wp-content/uploads/2015/11/Leg-Press.gif",
    muscle: "Quadriceps",
    sets: "3 Sets × 10 Reps",
    description: "Excellent machine exercise.",
    instructions: [
      "Place feet shoulder-width apart.",
      "Lower platform carefully.",
      "Push upward.",
      "Avoid locking knees."
    ],
  ),
  
  ExerciseModel(
    name: "Squat",
    image: "https://fitnessprogramer.com/wp-content/uploads/2024/10/smith-machine-squat.gif",
    muscle: "Quadriceps",
    sets: "3 Sets × 10 Reps",
    description: "King of leg exercises.",
    instructions: [
      "Keep chest up.",
      "Go below parallel.",
      "Drive through heels.",
      "Stand tall."
    ],
  ),


  ExerciseModel(
    name: "Romanian Deadlift",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Romanian-Deadlift.gif",
    muscle: "Hamstrings",
    sets: "3 Sets × 10 Reps",
    description: "Great hamstring builder.",
    instructions: [
      "Keep slight knee bend.",
      "Push hips back.",
      "Feel hamstring stretch.",
      "Return upright."
    ],
  ),

  ExerciseModel(
  name: "Bulgarian Split Squat",
  image: "https://fitnessprogramer.com/wp-content/uploads/2023/03/Bulgarian-Jump-Squat.gif",
  muscle: "Quadriceps & Glutes",
  sets: "3 Sets × 10 Reps",
  description: "Great unilateral leg exercise.",
  instructions: [
    "Place rear foot on bench.",
    "Lower body down.",
    "Push through front heel.",
    "Repeat."
  ],
),

ExerciseModel(
  name: "Walking Lunges",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/09/Walking-High-Knee-Lunges.gif",
  muscle: "Quadriceps & Glutes",
  sets: "3 Sets × 12 Reps",
  description: "Improves balance and leg strength.",
  instructions: [
    "Step forward.",
    "Lower into lunge.",
    "Push forward.",
    "Alternate legs."
  ],
),

ExerciseModel(
  name: "Leg Extension",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/LEG-EXTENSION.gif",
  muscle: "Quadriceps",
  sets: "4 Sets × 12 Reps",
  description: "Isolation exercise for quads.",
  instructions: [
    "Sit on machine.",
    "Extend legs upward.",
    "Pause.",
    "Lower slowly."
  ],
),

ExerciseModel(
  name: "Standing Calf Raise",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/05/Hack-Squat-Calf-Raise.gif",
  muscle: "Calves",
  sets: "4 Sets × 15 Reps",
  description: "Builds calf muscles.",
  instructions: [
    "Stand on platform.",
    "Raise heels upward.",
    "Pause.",
    "Lower slowly."
  ],
),

ExerciseModel(
  name: "Hip Thrust",
  image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Barbell-Hip-Thrust.gif",
  muscle: "Glutes",
  sets: "4 Sets × 10 Reps",
  description: "One of the best glute exercises.",
  instructions: [
    "Rest upper back on bench.",
    "Drive hips upward.",
    "Squeeze glutes.",
    "Lower slowly."
  ],
),
],

"Abs": [

  ExerciseModel(
    name: "Crunch",
    image: "https://fitnessprogramer.com/wp-content/uploads/2022/07/Cross-Crunch.gif",
    muscle: "Upper Abs",
    sets: "3 Sets × 15 Reps",
    description: "Basic ab exercise for upper abs.",
    instructions: [
      "Lie on the floor.",
      "Place hands on chest.",
      "Lift upper body.",
      "Contract abs at top."
    ],
  ),

  ExerciseModel(
    name: "Cable Crunch",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Kneeling-Cable-Crunch.gif",
    muscle: "Abs",
    sets: "3 Sets × 12 Reps",
    description: "Weighted ab exercise using cable machine.",
    instructions: [
      "Kneel in front of cable.",
      "Pull rope downward.",
      "Crunch abs.",
      "Return slowly."
    ],
  ),

  ExerciseModel(
    name: "Leg Raise",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Lying-Leg-Raise.gif",
    muscle: "Lower Abs",
    sets: "3 Sets × 12 Reps",
    description: "Targets lower abdominal muscles.",
    instructions: [
      "Lie flat on floor.",
      "Lift legs upward.",
      "Keep core tight.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Hanging Leg Raise",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/08/Hanging-Leg-Raises.gif",
    muscle: "Lower Abs",
    sets: "3 Sets × 10 Reps",
    description: "Advanced lower abs exercise.",
    instructions: [
      "Hang from bar.",
      "Lift legs upward.",
      "Avoid swinging.",
      "Lower slowly."
    ],
  ),

  ExerciseModel(
    name: "Russian Twist",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/02/Heel-Touch.gif",
    muscle: "Obliques",
    sets: "3 Sets × 20 Reps",
    description: "Core rotation exercise.",
    instructions: [
      "Sit on floor.",
      "Lean back slightly.",
      "Rotate torso side to side.",
      "Keep core tight."
    ],
  ),

  ExerciseModel(
    name: "Plank",
    image: "https://fitnessprogramer.com/wp-content/uploads/2023/07/High-Plank.gif",
    muscle: "Core",
    sets: "3 Sets × 60 sec",
    description: "Static core strength exercise.",
    instructions: [
      "Hold body straight.",
      "Elbows under shoulders.",
      "Keep core tight.",
      "Do not drop hips."
    ],
  ),

  ExerciseModel(
    name: "Mountain Climbers",
    image: "https://fitnessprogramer.com/wp-content/uploads/2022/07/Cross-Body-Mountain-Climber.gif",
    muscle: "Core + Cardio",
    sets: "3 Sets × 30 sec",
    description: "High intensity core exercise.",
    instructions: [
      "Get in push-up position.",
      "Alternate knee to chest.",
      "Move quickly.",
      "Keep body stable."
    ],
  ),
],

"Cardio": [
  ExerciseModel(
    name: "Treadmill",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Treadmill-.gif",
    muscle: "Cardio",
    sets: "20 min",
    description: "Indoor running for fat burning.",
    instructions: [
      "Start with warm-up.",
      "Increase speed gradually.",
      "Maintain posture.",
      "Cool down at end."
    ],
  ),

  ExerciseModel(
    name: "Cycling",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/06/Bike.gif",
    muscle: "Legs + Cardio",
    sets: "20 min",
    description: "Low impact cardio exercise.",
    instructions: [
      "Adjust seat height.",
      "Pedal steadily.",
      "Keep posture straight.",
      "Increase resistance if needed."
    ],
  ),

  ExerciseModel(
    name: "Jump Rope",
    image: "https://fitnessprogramer.com/wp-content/uploads/2023/10/Skip-Jump-Rope.gif",
    muscle: "Full Body",
    sets: "3 Sets × 2 min",
    description: "High calorie burning exercise.",
    instructions: [
      "Keep elbows close.",
      "Jump lightly.",
      "Maintain rhythm.",
      "Avoid heavy landing."
    ],
  ),

  ExerciseModel(
    name: "Stair Climber",
    image: "https://fitnessprogramer.com/wp-content/uploads/2021/10/Walking-on-Stepmill.gif",
    muscle: "Legs + Cardio",
    sets: "15 min",
    description: "Great for legs and fat burn.",
    instructions: [
      "Step continuously.",
      "Keep balance.",
      "Don’t lean forward.",
      "Maintain steady pace."
    ],
  ),
],
};