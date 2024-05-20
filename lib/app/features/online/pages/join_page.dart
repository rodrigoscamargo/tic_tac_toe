import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_buttom.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_text_field.dart';
import 'package:uuid/uuid.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final playerTextEditingController = TextEditingController();
  final roomTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFF36248D),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicTacToeTextField(
              label: 'Jogador',
              controller: playerTextEditingController,
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 8,
            ),
            TicTacToeTextField(
              label: 'Sala',
              controller: roomTextEditingController,
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 16,
            ),
            TicTacToeButton(
              text: 'Entrar na sala',
              onTap: () => Modular.to.pushNamed(
                '/online/game',
                arguments: {
                  'room': roomTextEditingController.text,
                  'player': Player(
                    id: const Uuid().v4(),
                    name: playerTextEditingController.text,
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
