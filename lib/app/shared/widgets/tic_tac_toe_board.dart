import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({
    super.key,
    required this.board,
    required this.makeMove,
    this.wait = false,
  });

  final List<SideType> board;
  final Function(int) makeMove;
  final bool? wait;

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: widget.board.length,
        itemBuilder: (context, index) {
          if (widget.board[index] == SideType.X) {
            return Container(
              decoration: BoxDecoration(border: Border.all()),
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
          if (widget.board[index] == SideType.O) {
            return Container(
              decoration: BoxDecoration(border: Border.all()),
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
            onTap: widget.wait! ? () {} : () => widget.makeMove(index),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
            ),
          );
        },
      ),
    );
  }
}
