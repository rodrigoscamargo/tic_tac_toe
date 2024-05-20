import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_appbar.dart';

import 'offline_game_controller.dart';

class OfflineGamePage extends StatefulWidget {
  const OfflineGamePage({super.key});

  @override
  State<OfflineGamePage> createState() => _OfflineGamePageState();
}

class _OfflineGamePageState extends State<OfflineGamePage> {
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

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final controller = OfflineGameController(ticTacToe: TicTacToeImpl());

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
                  return Card(
                    child: Center(
                      child: Text(
                        SideType.X.name,
                        style: GoogleFonts.carterOne(
                          textStyle: const TextStyle(
                            fontSize: 50,
                            color: Color(0XFFEB1751),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (board[index] == SideType.O) {
                  return Card(
                    child: Center(
                      child: Text(
                        SideType.O.name,
                        style: GoogleFonts.carterOne(
                          textStyle: const TextStyle(
                            fontSize: 50,
                            color: Color(0XFFFFD032),
                          ),
                        ),
                      ),
                    ),
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
  void setSide(SideType side) {
    currentPiece = side;
  }

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
