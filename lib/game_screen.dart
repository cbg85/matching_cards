import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int gridSize = 4; // Creates a 4x4 grid
  List<bool> cardFlipped = List.generate(gridSize * gridSize, (index) => false);

  void flipCard(int index) {
    setState(() {
      cardFlipped[index] = !cardFlipped[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Matching Game"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize, // Creates a 4x4 grid
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => flipCard(index),
              child: Container(
                decoration: BoxDecoration(
                  color: cardFlipped[index] ? Colors.white : Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: cardFlipped[index]
                      ? Text(
                    "$index", // Replace this with actual card images or icons
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )
                      : const Icon(Icons.question_mark, size: 32, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
