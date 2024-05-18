import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_buttom.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_text_field.dart';
import 'package:uuid/uuid.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final playerTextEditingController = TextEditingController();

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
              controller: playerTextEditingController,
              label: 'Jogador',
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 16,
            ),
            TicTacToeButton(
              text: 'Criar sala',
              onTap: () => Modular.to.pushNamed(
                '/online/game',
                arguments: {
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
