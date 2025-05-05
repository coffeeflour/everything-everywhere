import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../chores/chores_screen/widgets/chores_screen.dart';

var logger = Logger();

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}




class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This app is being developed to help manage chores.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logger.t('Navigating to Chores Page...');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChoreScreen(title: 'Chores'),
                
                 ),
              );
              },
              child: const Text('Go to Chores Page'),
            ),
        ],
        ),
      ),
    );
  }
}
