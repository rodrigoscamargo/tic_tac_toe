import 'package:flutter/material.dart';

class TicTacToeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TicTacToeAppBar({
    super.key,
    this.room,
  });

  final String? room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        roomCode
      ],
    );
  }

  Widget get roomCode {
     
     if(room == null){
      return const SizedBox();
     }

    return Row(children: [Text('Sala: $room')],);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
