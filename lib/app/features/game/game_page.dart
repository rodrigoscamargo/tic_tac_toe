import 'package:flutter/material.dart';

import 'game_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SafeArea(
        child: Column(
          children: [
            TicTacToeAppBar(),
            TicTacToeBoard(),
          ],
        ),
      ),
    );
  }
}

class TicTacToeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TicTacToeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      fallbackHeight: 100,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final controller = GameController(ticTacToe: TicTacToeImpl());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: controller.board,
          builder: (_, board, __) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: board.length,
              itemBuilder: (context, index) {
                if (board[index] == SideType.X) {
                  return const Card(
                    child: Text('X'),
                  );
                }
                if (board[index] == SideType.O) {
                  return const Card(
                    child: Text('O'),
                  );
                }

                return InkWell(
                  onTap: () => controller.makeMove(index),
                  child: const Card(),
                );
              },
            );
          }),
    );
  }
}

class TicTacToeImpl implements TicTacToe {
  TicTacToeImpl({
    this.currentPiece = SideType.X,
  }) {
    board = List.filled(9, SideType.empty);
  }

  @override
  late List<SideType> board;

  @override
  SideType currentPiece;

  @override
  bool canMove(int index) {
    return board[index] == SideType.empty;
  }

  @override
  void move(int index) {
    board[index] = currentPiece;
  }

  @override
  void nextTurn() {
    if (currentPiece == SideType.X) {
      currentPiece = SideType.O;
      return;
    }

    if (currentPiece == SideType.O) {
      currentPiece = SideType.X;
      return;
    }
  }

  @override
  bool verifyWinner() {
    final winners = ['012', '048', '036', '147', '246', '258', '345', '678'];

    for (String win in winners) {
      if (board[int.parse(win[0])] == board[int.parse(win[1])] &&
          board[int.parse(win[1])] == board[int.parse(win[2])] &&
          board[int.parse(win[2])] == currentPiece) {
        return true;
      }
    }

    return false;
  }

  @override
  bool verifyTie() {
    return !board.contains(SideType.empty);
  }
}
