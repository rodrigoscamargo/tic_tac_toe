import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';

class SideButton extends StatelessWidget {
  final SideType sideType;
  final TextStyle style;
  final VoidCallback onPressed;

  const SideButton({
    super.key,
    required this.sideType,
    required this.onPressed,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            sideType.name,
            style: style,
          ),
        ),
      ),
    );
  }
}
