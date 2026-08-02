import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('users').doc(uid).set(
      data,
      SetOptions(merge: true),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).get();
  }

  static bool isProfileComplete(Map<String, dynamic>? data) {
    if (data == null) return false;

    // إذا كنت تستخدم فلج صريح في Firebase، نتحقق منه أولاً
    if (data['profileCompleted'] == true) return true;

    // قائمة المفاتيح المطلوبة لضمان وجودها
    final List<String> requiredKeys = [
      'age',
      'height',
      'weight',
      'gender',
      'goal',
      'caloriesGoal',
      'waterGoal',
    ];

    // التحقق: هل كل مفتاح موجود في الـ Map وقيمته ليست null؟
    return requiredKeys.every((key) =>
    data.containsKey(key) && data[key] != null && data[key].toString().trim().isNotEmpty
    );
  }

  Future<void> updateWaterConsumed(String uid, int newValue) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'waterConsumed': newValue,
      });
    } catch (e) {
      print("Error updating water: $e");
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
    getUserStream(String uid) {
  return _firestore
      .collection('users')
      .doc(uid)
      .snapshots();
}

Future<void> addMeal({
  required String uid,
  required String mealName,
  required int calories,
}) async {
  final docRef = _firestore.collection('users').doc(uid);

  await _firestore.runTransaction((transaction) async {
    final snapshot = await transaction.get(docRef);

    final data = snapshot.data();

    if (data == null) return;

    final rawMeals = data['meals'];

    List<Map<String, dynamic>> meals = [];

    if (rawMeals is List) {
      meals = List<Map<String, dynamic>>.from(rawMeals);
    }

    meals.add({
      'name': mealName,
      'calories': calories,
      'date': DateTime.now().toIso8601String(),
    });

    transaction.update(docRef, {
      'meals': meals,
      'caloriesConsumed': FieldValue.increment(calories),
    });
  });
  }
  Future<void> resetDailyData(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'caloriesConsumed': 0,
      'waterConsumed': 0,
      'meals': [],
    });
  }
}
