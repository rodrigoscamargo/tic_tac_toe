import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const TicTacToeButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      textColor: Colors.white,
      color: const Color(0XFF27175D),
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.paytoneOne(
          textStyle: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
