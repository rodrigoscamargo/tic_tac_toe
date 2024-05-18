import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_buttom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFF36248D),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicTacToeButton(
              text: 'Cara a Cara',
              onTap: () => Modular.to.pushNamed('/game/vis-a-vis'),
            ),
            const SizedBox(
              height: 8,
            ),
            TicTacToeButton(
              text: 'Consegue me derrotar?',
              onTap: () => Modular.to.pushNamed('/game/ai'),
            ),
            const SizedBox(
              height: 8,
            ),
            TicTacToeButton(
              text: 'Chame um amigo',
              onTap: () => Modular.to.pushNamed('/online/'),
            ),
          ],
        ),
      ),
    );
  }
}
