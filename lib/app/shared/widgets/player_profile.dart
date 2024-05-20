import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';

class PlayerProfile extends StatelessWidget {
  final Player player;
  const PlayerProfile({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            player.piece?.name ?? '',
            style: player.piece == SideType.X
                ? GoogleFonts.carterOne(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      color: Color(0XFFEB1751),
                    ),
                  )
                : GoogleFonts.paytoneOne(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      color: Color(0XFFFFD032),
                    ),
                  ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            player.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
