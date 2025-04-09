import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isRunning = false;
  int _totalSeconds = 0;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startTimer() {
    if (_totalSeconds <= 0) return;

    setState(() {
      _isRunning = true;
      _startTime = DateTime.now().add(Duration(seconds: _totalSeconds));
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isRunning) {
        timer.cancel();
        return;
      }

      final now = DateTime.now();
      final remaining = _startTime.difference(now);

      setState(() {
        _totalSeconds = remaining.inSeconds;
        if (_totalSeconds <= 0) {
          _totalSeconds = 0;
          _isRunning = false;
          timer.cancel();
        }

        _hours = _totalSeconds ~/ 3600;
        _minutes = (_totalSeconds % 3600) ~/ 60;
        _seconds = _totalSeconds % 60;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    });
  }

  void _updateTimerValues() {
    setState(() {
      _totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    });
  }

  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            if (!_isRunning) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Hours'),
                      NumberPicker(
                        value: _hours,
                        minValue: 0,
                        maxValue: 23,
                        onChanged: (value) {
                          setState(() => _hours = value);
                          _updateTimerValues();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const Text('Minutes'),
                      NumberPicker(
                        value: _minutes,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) {
                          setState(() => _minutes = value);
                          _updateTimerValues();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const Text('Seconds'),
                      NumberPicker(
                        value: _seconds,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) {
                          setState(() => _seconds = value);
                          _updateTimerValues();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    _isRunning ? 'Stop' : 'Start',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_drop_up, size: 30),
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
        Container(
          width: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_drop_down, size: 30),
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
        ),
      ],
    );
  }
}