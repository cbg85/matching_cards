import 'package:flutter/material.dart';

class CardModel {
  final int id;
  final String image; // Represents the front image of the card
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.id,
    required this.image,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}

class GameProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  CardModel? _firstFlippedCard;
  bool _isChecking = false;

  GameProvider() {
    _initializeGame();
  }

  List<CardModel> get cards => _cards;
  bool get isChecking => _isChecking;

  void _initializeGame() {
    List<String> images = [
      'assets/card1.png',
      'assets/card2.png',
      'assets/card3.png',
      'assets/card4.png',
      'assets/card5.png',
      'assets/card6.png',
      'assets/card7.png',
      'assets/card8.png',
    ];

    images = [...images, ...images]; // Duplicate images for pairs
    images.shuffle(); // Shuffle the deck

    _cards = List.generate(images.length, (index) {
      return CardModel(id: index, image: images[index]);
    });

    notifyListeners();
  }

  void flipCard(int index) {
    if (_isChecking || _cards[index].isMatched || _cards[index].isFaceUp) {
      return;
    }

    _cards[index].isFaceUp = true;
    notifyListeners();

    if (_firstFlippedCard == null) {
      _firstFlippedCard = _cards[index];
    } else {
      _isChecking = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {
        _checkForMatch(index);
      });
    }
  }

  void _checkForMatch(int secondIndex) {
    if (_firstFlippedCard != null) {
      if (_firstFlippedCard!.image == _cards[secondIndex].image) {
        _firstFlippedCard!.isMatched = true;
        _cards[secondIndex].isMatched = true;
      } else {
        _firstFlippedCard!.isFaceUp = false;
        _cards[secondIndex].isFaceUp = false;
      }
    }

    _firstFlippedCard = null;
    _isChecking = false;
    notifyListeners();
  }

  void resetGame() {
    _initializeGame();
    _firstFlippedCard = null;
    _isChecking = false;
    notifyListeners();
  }
}
