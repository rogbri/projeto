import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<Alarm> _alarms = [];
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addAlarm() {
    setState(() {
      _alarms.add(Alarm(time: _selectedTime));
    });
  }

  void _removeAlarm(int index) {
    setState(() {
      _alarms.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarms')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text(
                    _selectedTime.format(context),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addAlarm,
                  child: const Text('Add Alarm'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _alarms.length,
              itemBuilder: (context, index) {
                final alarm = _alarms[index];
                return ListTile(
                  leading: const Icon(Icons.alarm),
                  title: Text(alarm.time.format(context)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeAlarm(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Alarm {
  final TimeOfDay time;
  Alarm({required this.time});
}