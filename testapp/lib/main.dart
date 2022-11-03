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
    return const MaterialApp(
      title: "Variable Name Generator",
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> suggestions = <WordPair>[];
  final Set<WordPair> favourites = <WordPair>{};
  TextStyle biggerFont = const TextStyle(fontSize: 18);

  void pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final Iterable<ListTile> tiles = favourites.map(
        (pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: biggerFont,
            ),
          );
        },
      );

      final dynamic divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            )
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text("Favourite names"),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Variable Name Generator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: pushSaved,
            tooltip: "Favourites",
          ),
        ],
      ),
      body: ListView.builder(
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

          final bool isFavourite = favourites.contains(suggestions[i]);

          return ListTile(
            title: Text(
              suggestions[i].asPascalCase,
              style: biggerFont,
            ),
            trailing: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.red : null,
              semanticLabel: isFavourite ? "Remove from favourites" : "Save",
            ),
            onTap: () {
              setState(() {
                if (isFavourite) {
                  favourites.remove(suggestions[i]);
                } else {
                  favourites.add(suggestions[i]);
                }
              });
            },
          );
        }),
      ),
    );
  }
}
