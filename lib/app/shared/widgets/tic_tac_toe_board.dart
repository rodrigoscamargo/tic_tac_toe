import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/features/game/game_controller.dart';

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
            return Card(
              child: Text(SideType.X.side),
            );
          }
          if (widget.board[index] == SideType.O) {
            return Card(
              child: Text(SideType.O.side),
            );
          }

          return InkWell(
            onTap: !widget.wait! ? widget.makeMove(index) : () {},
            child: const Card(),
          );
        },
      ),
    );
  }
}
