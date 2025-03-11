import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart'; // Import the provider

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust this for the number of cards per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: gameProvider.cards.length,
            itemBuilder: (context, index) {
              final card = gameProvider.cards[index];
              return GestureDetector(
                onTap: () => gameProvider.flipCard(index),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),  // Flip animation duration
                  transitionBuilder: (child, animation) {
                    // We want to flip the card, so we'll rotate it
                    return RotationY(
                      turns: animation,
                      child: child,
                    );
                  },
                  child: card.isFaceUp
                      ? Image.asset(card.frontImage, key: ValueKey(card.frontImage))
                      : Image.asset(card.backImage, key: ValueKey(card.backImage)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RotationY extends StatelessWidget {
  final Widget child;
  final Animation<double> turns;

  RotationY({required this.turns, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: turns,
      child: child,
      builder: (context, child) {
        final rotate = turns.value * 3.1416; // Rotating by 180 degrees
        return Transform(
          transform: Matrix4.rotationY(rotate),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
