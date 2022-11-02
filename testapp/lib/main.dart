import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Variable Name Generator",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Variable Name Generator"),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final List<WordPair> suggestions = <WordPair>[];
    const TextStyle biggerFont = TextStyle(fontSize: 18);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: ((context, index) {
        if (index.isOdd) {
          return const Divider(
            thickness: 2,
          );
        }

        // If the index reaches half of the length, double the length
        final int i = index ~/ 2; // Integer division
        if (i >= suggestions.length) {
          if (kDebugMode) {
            print("ADDED MORE!");
          }
          suggestions.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            suggestions[i].asPascalCase,
            style: biggerFont,
          ),
        );
      }),
    );
  }
}
