import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart'; // Import the provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust based on how many cards you want per row
            ),
            itemCount: gameProvider.cards.length,
            itemBuilder: (context, index) {
              final card = gameProvider.cards[index];
              return GestureDetector(
                onTap: () => gameProvider.flipCard(index),
                child: Card(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: card.isFaceUp
                        ? Image.asset(card.frontImage, key: ValueKey(card.frontImage))
                        : Image.asset(card.backImage, key: ValueKey(card.backImage)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
