import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Timer and Stuffs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('Alarm'),
              onTap: () {
                Navigator.pushNamed(context, '/alarm');
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Stopwatch'),
              onTap: () {
                Navigator.pushNamed(context, '/stopwatch');
              },
            ),
            ListTile(
              leading: const Icon(Icons.hourglass_bottom),
              title: const Text('Timer'),
              onTap: () {
                Navigator.pushNamed(context, '/timer');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Groceries'),
              onTap: () {
                Navigator.pushNamed(context, '/groceries');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Timer and stuffs app!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}