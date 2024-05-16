import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/online/online_controller.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_appbar.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_board.dart';

class OnlineGamePage extends StatefulWidget {
  const OnlineGamePage({super.key});

  @override
  State<OnlineGamePage> createState() => _OnlineGamePageState();
}

class _OnlineGamePageState extends State<OnlineGamePage> {
  final controller = Modular.get<OnlineController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: controller.room,
            builder: (_, room, __) {
              return ValueListenableBuilder(
                  valueListenable: controller.ready,
                  builder: (_, ready, __) {
                    if (room != null) {
                      return Column(
                        children: [
                          TicTacToeAppBar(
                            room: room,
                          ),
                          if (ready)
                            SizedBox(
                              height: 500,
                              child: ValueListenableBuilder(
                                  valueListenable: controller.wait,
                                  builder: (_, wait, __) {
                                    return ValueListenableBuilder(
                                        valueListenable: controller.board,
                                        builder: (_, board, __) {
                                          return TicTacToeBoard(
                                            board: board,
                                            makeMove: controller.makeMove,
                                            wait: wait,
                                          );
                                        });
                                  }),
                            )
                          else
                            const SizedBox(
                              child: Column(children: [
                                Text('Agauardando Jogador!'),
                                SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator(),
                              ]),
                            )
                        ],
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: controller.createRoom,
                          child: const Text('Criar'),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
