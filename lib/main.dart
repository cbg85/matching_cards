import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(const CardMatchingGame());
}

class CardMatchingGame extends StatelessWidget {
  const CardMatchingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
