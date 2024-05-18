import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TicTacToeAppBar({
    super.key,
    this.room,
  });

  final String? room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [roomCode],
    );
  }

  Widget get roomCode {
    if (room == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            'Sala: $room',
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
