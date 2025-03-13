import 'package:flutter/material.dart';

class CardModel {
  final String frontImage;
  final String backImage;
  bool isFaceUp;

  CardModel({required this.frontImage, required this.backImage, this.isFaceUp = false});
}

class GameProvider with ChangeNotifier {
  List<CardModel> _cards = [
    CardModel(frontImage: 'assets/front_club.jpg', backImage: 'assets/club_back.jpg'),
    CardModel(frontImage: 'assets/front_diamond.jpg', backImage: 'assets/diamond_back.jpg'),
    CardModel(frontImage: 'assets/front_heart.jpg', backImage: 'assets/heart_back.jpg'),
    CardModel(frontImage: 'assets/front_spade.jpg', backImage: 'assets/spade_back.jpg'),
    CardModel(frontImage: 'assets/front_club.jpg', backImage: 'assets/club_back.jpg'),
    CardModel(frontImage: 'assets/front_diamond.jpg', backImage: 'assets/diamond_back.jpg'),
    CardModel(frontImage: 'assets/front_heart.jpg', backImage: 'assets/heart_back.jpg'),
    CardModel(frontImage: 'assets/front_spade.jpg', backImage: 'assets/spade_back.jpg'),
    // Add more cards to complete the 4x4 grid
    // For example, you can duplicate the above 4 cards to get 16 cards total.
  ];

  List<CardModel> get cards => _cards;

  int? _firstFlippedIndex;
  bool _isProcessing = false;

  void flipCard(int index) {
    if (_isProcessing || _cards[index].isFaceUp) return; // Prevent flipping if already flipped or in processing state
    _cards[index].isFaceUp = true;
    notifyListeners();

    if (_firstFlippedIndex == null) {
      // First card is flipped
      _firstFlippedIndex = index;
    } else {
      // Second card is flipped
      _isProcessing = true; // Prevent further actions while checking for match
      if (_cards[index].frontImage == _cards[_firstFlippedIndex!].frontImage) {
        // It's a match, leave both face up
        _firstFlippedIndex = null;
        _isProcessing = false;
      } else {
        // Not a match, flip both cards back down after a short delay
        Future.delayed(Duration(seconds: 1), () {
          _cards[index].isFaceUp = false;
          _cards[_firstFlippedIndex!].isFaceUp = false;
          _firstFlippedIndex = null;
          _isProcessing = false;
          notifyListeners();
        });
      }
    }
  }

  void shuffleCards() {
    _cards.shuffle();
    notifyListeners();
  }
}
