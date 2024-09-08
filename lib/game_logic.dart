import 'dart:math';
import 'package:flutter/material.dart';

// Player class to store player data
class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

// Game class to handle game logic
class Game {
  // Play game for the current player
  void playGame(int index, String activePlayer) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  // Auto-play for the computer
  Future<void> autoPlay(String activePlayer) async {
    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!Player.playerX.contains(i) && !Player.playerO.contains(i)) {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      int index = emptyCells[randomIndex];
      playGame(index, activePlayer);
    }
  }

  // Check for a winner
  String checkWinner() {
    List<List<int>> winningPatterns = [
      // Rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonals
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winningPatterns) {
      if (Player.playerX.toSet().containsAll(pattern)) {
        return Player.x;
      } else if (Player.playerO.toSet().containsAll(pattern)) {
        return Player.o;
      }
    }

    return '';
  }
}
