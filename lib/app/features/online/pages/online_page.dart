import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_buttom.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFF36248D),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicTacToeButton(
              text: 'Crie uma sala',
              onTap: () => Modular.to.pushNamed('/online/create'),
            ),
            const SizedBox(
              height: 8,
            ),
            TicTacToeButton(
              text: 'Entrar em uma sala',
              onTap: () => Modular.to.pushNamed('/online/join'),
            ),
          ],
        ),
      ),
    );
  }
}
