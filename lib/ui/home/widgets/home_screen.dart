import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../chores/view_all_chores/widgets/view_all_chores_screen.dart';

var logger = Logger();

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}




class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
                  builder: (context) => const ViewAllChoresScreen(title: 'All chores'),
                
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
