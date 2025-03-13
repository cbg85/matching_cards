import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart'; // Import the GameProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'Card Matching Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CardMatchingScreen(), // Set the home screen to CardMatchingScreen
      ),
    );
  }
}

class CardMatchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Matching Game'),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return GridView.builder(
            itemCount: gameProvider.cards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,  // Set 4 columns for the 4x4 grid
            ),
            itemBuilder: (context, index) {
              final card = gameProvider.cards[index];
              return GestureDetector(
                onTap: () => gameProvider.flipCard(index),
                child: Card(
                  elevation: 4,
                  child: Center(
                    child: Image.asset(
                      card.isFaceUp ? card.frontImage : card.backImage,
                      fit: BoxFit.cover,
                    ),
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
