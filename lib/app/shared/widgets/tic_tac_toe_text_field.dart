import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToeTextField extends StatelessWidget {
  final String label;
  final String text;

  const TicTacToeTextField({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.carterOne(
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(15)],
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                fillColor: Color(0XFF27175D),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
