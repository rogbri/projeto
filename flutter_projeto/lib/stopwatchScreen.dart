import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool _isRunning = false;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  late DateTime _lastTime;

  @override
  void initState() {
    super.initState();
    _lastTime = DateTime.now();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _lastTime = DateTime.now();
    });
    _updateTime();
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _seconds = 0;
      _minutes = 0;
      _hours = 0;
    });
  }

  void _updateTime() {
    if (_isRunning) {
      Future.delayed(const Duration(milliseconds: 100), () {
        final now = DateTime.now();
        final diff = now.difference(_lastTime);
        _lastTime = now;
        
        setState(() {
          _seconds += diff.inSeconds;
          if (_seconds >= 60) {
            _minutes += _seconds ~/ 60;
            _seconds = _seconds % 60;
          }
          if (_minutes >= 60) {
            _hours += _minutes ~/ 60;
            _minutes = _minutes % 60;
          }
        });
        _updateTime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}