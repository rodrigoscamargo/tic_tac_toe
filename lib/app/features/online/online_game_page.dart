import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';
import 'package:tic_tac_toe/app/features/online/online_controller.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_appbar.dart';
import 'package:tic_tac_toe/app/shared/widgets/tic_tac_toe_board.dart';

class OnlineGamePage extends StatefulWidget {
  const OnlineGamePage({
    super.key,
    required this.player,
    this.room,
  });

  final Player player;
  final String? room;

  @override
  State<OnlineGamePage> createState() => _OnlineGamePageState();
}

class _OnlineGamePageState extends State<OnlineGamePage> {
  final controller = Modular.get<OnlineController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.room == null) {
        controller.player.value = widget.player;
        controller.createRoom();
      } else {
        controller.room.value = widget.room;
        controller.joinRoom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFF36248D),
      child: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: controller.room,
            builder: (_, room, __) {
              return ValueListenableBuilder(
                  valueListenable: controller.opponent,
                  builder: (_, opponent, __) {
                    return ValueListenableBuilder(
                        valueListenable: controller.start,
                        builder: (_, start, __) {
                          return ValueListenableBuilder(
                              valueListenable: controller.ready,
                              builder: (_, ready, __) {
                                return ValueListenableBuilder(
                                    valueListenable: controller.chooseSide,
                                    builder: (_, chooseSide, __) {
                                      if (room != null) {
                                        return Column(
                                          children: [
                                            TicTacToeAppBar(
                                              room: room,
                                            ),
                                            PlayersPanel(
                                              player1: controller.player.value!,
                                              player2: opponent,
                                            ),
                                            if (ready && chooseSide && !start)
                                              ChooseSide(
                                                chooseASide:
                                                    controller.chooseASide,
                                              ),
                                            SizedBox(
                                              height: 500,
                                              child: ValueListenableBuilder(
                                                  valueListenable:
                                                      controller.start,
                                                  builder: (_, start, __) {
                                                    return ValueListenableBuilder(
                                                        valueListenable:
                                                            controller.wait,
                                                        builder: (_, wait, __) {
                                                          return ValueListenableBuilder(
                                                              valueListenable:
                                                                  controller
                                                                      .board,
                                                              builder: (_,
                                                                  board, __) {
                                                                if (start) {
                                                                  return TicTacToeBoard(
                                                                    board:
                                                                        board,
                                                                    makeMove:
                                                                        controller
                                                                            .makeMove,
                                                                    wait: wait,
                                                                  );
                                                                }else{
                                                                  return const SizedBox();
                                                                }
                                                              });
                                                        });
                                                  }),
                                            )
                                            // else
                                            //   const WaitingOpponentChooseSide()
                                          ],
                                        );
                                      }

                                      return const SizedBox();
                                    });
                              });
                        });
                  });
            }),
      ),
    );
  }
}

class RoomDetail extends StatelessWidget {
  const RoomDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PlayersPanel extends StatelessWidget {
  final Player player1;
  final Player? player2;

  const PlayersPanel({
    super.key,
    required this.player1,
    this.player2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                CircleAvatar(
                  minRadius: 40,
                  child: Text(player1.piece?.name ?? ''),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  player1.name,
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
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            'VS',
            textAlign: TextAlign.center,
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                CircleAvatar(
                  minRadius: 40,
                  child: Text(player2?.piece?.name ?? ''),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  player2!.name,
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
          ),
        ),
      ],
    );
  }
}

class ChooseSide extends StatelessWidget {
  const ChooseSide({
    super.key,
    required this.chooseASide,
  });

  final Function(SideType) chooseASide;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          Text(
            'Escolha a peca',
            textAlign: TextAlign.center,
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => chooseASide(SideType.X),
                child: Text(SideType.X.name),
              ),
              Text(
                'OU',
                textAlign: TextAlign.center,
                style: GoogleFonts.paytoneOne(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => chooseASide(SideType.O),
                child: Text(SideType.O.name),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class WaitingOpponent extends StatelessWidget {
  const WaitingOpponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          Text(
            'Esparando outro jogador\nentrar na sala!',
            textAlign: TextAlign.center,
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingOpponentChooseSide extends StatelessWidget {
  const WaitingOpponentChooseSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          Text(
            'Esparando jogador escolher a peca',
            textAlign: TextAlign.center,
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
