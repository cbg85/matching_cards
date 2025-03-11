import 'package:flutter/material.dart';

class CardModel {
  final String frontImage;
  final String backImage;
  bool isFaceUp;

  CardModel({
    required this.frontImage,
    required this.backImage,
    this.isFaceUp = false,
  });
}

class GameProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  List<CardModel> get cards => _cards;

  int? _firstCardIndex;
  int? _secondCardIndex;

  GameProvider() {
    _initializeCards();
  }

  void _initializeCards() {
    // List of front images for the cards
    List<String> frontImages = [
      'assets/front_club.png',
      'assets/front_diamond.png',
      'assets/front_heart.png',
      'assets/front_spade.png',
    ];

    // Shuffle and duplicate to create pairs
    List<CardModel> tempCards = [];
    for (var frontImage in frontImages) {
      tempCards.add(CardModel(frontImage: frontImage, backImage: 'assets/spade_back.png'));
      tempCards.add(CardModel(frontImage: frontImage, backImage: 'assets/spade_back.png'));
    }

    // Shuffle cards
    tempCards.shuffle();

    // Assign shuffled cards to _cards
    _cards = tempCards;
    notifyListeners();
  }

  void flipCard(int index) {
    if (_cards[index].isFaceUp) return;  // Don't flip if already face-up
    _cards[index].isFaceUp = true;

    // Check for pair match
    if (_firstCardIndex == null) {
      _firstCardIndex = index;
    } else if (_secondCardIndex == null) {
      _secondCardIndex = index;
      _checkForMatch();
    }

    notifyListeners();
  }

  void _checkForMatch() {
    // Delay for the animation to complete
    Future.delayed(Duration(seconds: 1), () {
      if (_cards[_firstCardIndex!].frontImage == _cards[_secondCardIndex!].frontImage) {
        // If they match, leave them face-up
      } else {
        // If they don't match, flip them face-down again
        _cards[_firstCardIndex!].isFaceUp = false;
        _cards[_secondCardIndex!].isFaceUp = false;
      }

      // Reset selected cards
      _firstCardIndex = null;
      _secondCardIndex = null;
      notifyListeners();
    });
  }
}
