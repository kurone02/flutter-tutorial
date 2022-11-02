import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  List<Color>? color;

  @override
  void initState() {
    color = List<Color>.generate(20, (index) => randomColor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Testing Flutter"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (kDebugMode) {
              print("pressed!");
            }
            setState(() {
              count++;
            });
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index) {
            return Container(
              color: color?[index],
              width: 500,
              height: 500,
              child: Center(
                child: Text(
                  "${count + index}",
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "Buisiness",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "School",
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item ${index + 1}'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
