import 'dart:async';
import 'package:flutter/material.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final Map<String, dynamic> workout;
  const ActiveWorkoutScreen({super.key, required this.workout});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int _countdown = 3;
  int _stopwatchSeconds = 0;
  int _restSeconds = 0;
  bool _isResting = false;
  bool _isRunning = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() {
          _countdown = 0;
          _startStopwatch();
        });
      }
    });
  }

  void _startStopwatch() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _stopwatchSeconds++);
    });
  }

  void _toggleStopwatch() {
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
      } else {
        _startStopwatch();
      }
      _isRunning = !_isRunning;
    });
  }

  void _startRest() {
    _timer?.cancel();
    setState(() {
      _isResting = true;
      _restSeconds = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restSeconds > 0) {
        setState(() => _restSeconds--);
      } else {
        timer.cancel();
        setState(() {
          _isResting = false;
          _isRunning = true;
          _startStopwatch();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_countdown > 0) {
      return Scaffold(
        body: Center(
          child: Text("$_countdown", style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout['exerciseName'])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isResting ? "Rest for 60 seconds" : "Workout in progress",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              _isResting ? _formatTime(_restSeconds) : _formatTime(_stopwatchSeconds),
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()]),
            ),
            const SizedBox(height: 50),

            // زرار التحكم (Toggle)
            if (!_isResting)
              GestureDetector(
                onTap: _toggleStopwatch,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRunning ? Colors.red.withOpacity(0.15) : Colors.green.withOpacity(0.15),
                  ),
                  child: Icon(
                    _isRunning ? Icons.stop : Icons.play_arrow,
                    color: _isRunning ? Colors.red : Colors.green,
                    size: 40,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // زرار إنهاء المجموعة
            if (!_isResting)
              ElevatedButton(
                onPressed: _startRest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color(0xFF6233D7),
                ),
                child: const Text("Finish Set & Rest", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}