import 'package:flutter/material.dart';

class OfflineGameController {
  final TicTacToe ticTacToe;

  OfflineGameController({required this.ticTacToe});

  final currentPiece = ValueNotifier<SideType>(SideType.empty);
  final board = ValueNotifier<List<SideType>>(List.filled(9, SideType.empty));

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
  late List<SideType> board = List.filled(9, SideType.empty);
  SideType currentPiece = SideType.empty;

  void setSide(SideType side);
  void move(int index);
  bool canMove(int index);
  void nextTurn();
  bool verifyWinner();
  bool verifyTie();
}

enum SideType {
  O('O'),
  X('X'),
  empty('empty');

  final String side;

  const SideType(this.side);

  static SideType? fromString(String? value) =>
      switch (value) { "O" => O, "X" => X, "empty" => empty, _ => null };
}
