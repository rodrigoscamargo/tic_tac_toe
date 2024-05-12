import 'package:flutter/material.dart';

class GameController {
  final TicTacToe ticTacToe;

  GameController({required this.ticTacToe});

  final currentPiece = ValueNotifier<PieceType>(PieceType.empty);
  final board = ValueNotifier<List<PieceType>>(List.filled(9, PieceType.empty));

  void makeMove(int index) {
    {
      if (ticTacToe.canMove(index)) {
        ticTacToe.move(index);

        board.value = List.from(ticTacToe.board);

        if (ticTacToe.verifyWinner()) {
          return;
        }

        if (ticTacToe.verifyTie()) {
          return;
        }

        ticTacToe.nextTurn();

        currentPiece.value = ticTacToe.currentPiece;
      }
    }
  }
}

abstract class TicTacToe {
  late List<PieceType> board = List.filled(9, PieceType.empty);
  PieceType currentPiece = PieceType.empty;

  void move(int index);
  bool canMove(int index);
  void nextTurn();
  bool verifyWinner();
  bool verifyTie();
}

enum PieceType { O, X, empty }
