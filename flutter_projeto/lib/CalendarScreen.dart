import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final Map<DateTime, List<String>> _annotations = {};
  final TextEditingController _annotationController = TextEditingController();

  void _addAnnotation(DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add annotation for ${DateFormat('MMM dd, yyyy').format(date)}'),
        content: TextField(
          controller: _annotationController,
          decoration: const InputDecoration(hintText: 'Enter annotation'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _annotations[date] ??= [];
                _annotations[date]!.add(_annotationController.text);
                _annotationController.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: SfCalendar(
        view: CalendarView.month,
        onTap: (calendarTapDetails) {
          if (calendarTapDetails.date != null) {
            _addAnnotation(calendarTapDetails.date!);
          }
        },
        dataSource: _AnnotationDataSource(_annotations),
      ),
    );
  }
}

class _AnnotationDataSource extends CalendarDataSource {
  _AnnotationDataSource(Map<DateTime, List<String>> annotations) {
    appointments = annotations.entries.map((entry) {
      return _Annotation(
        entry.key,
        entry.value.join('\n'),
      );
    }).toList();
  }
}

class _Annotation {
  _Annotation(this.date, this.note);
  final DateTime date;
  final String note;
}