import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';
import 'package:tic_tac_toe/app/features/online/online_controller.dart';
import 'package:tic_tac_toe/app/shared/widgets/player_profile.dart';
import 'package:tic_tac_toe/app/shared/widgets/side_button.dart';
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
        controller.player.value = widget.player;
        controller.joinRoom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFF36248D),
      child: SafeArea(
        child: SingleChildScrollView(
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
                                          return ValueListenableBuilder(
                                              valueListenable: controller.wait,
                                              builder: (_, wait, __) {
                                                return Column(
                                                  children: [
                                                    TicTacToeAppBar(
                                                      room: room,
                                                    ),
                                                    PlayersPanel(
                                                      player1: controller
                                                          .player.value!,
                                                      player2: opponent,
                                                      myTurn: !wait,
                                                    ),
                                                    if (ready &&
                                                        chooseSide &&
                                                        !start)
                                                      ChooseSide(
                                                        chooseASide: controller
                                                            .chooseASide,
                                                      ),
                                                    SizedBox(
                                                      height: 500,
                                                      child:
                                                          ValueListenableBuilder(
                                                              valueListenable:
                                                                  controller
                                                                      .board,
                                                              builder:
                                                                  (_, board, __) {
                                                                if (start) {
                                                                  return Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            24,
                                                                      ),
                                                                      Turn(
                                                                        player1: controller
                                                                            .player
                                                                            .value!,
                                                                        player2:
                                                                            opponent!,
                                                                        myTurn:
                                                                            !wait,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            24,
                                                                      ),
                                                                      TicTacToeBoard(
                                                                        board:
                                                                            board,
                                                                        makeMove:
                                                                            controller
                                                                                .makeMove,
                                                                        wait:
                                                                            wait,
                                                                      ),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return const SizedBox();
                                                                }
                                                              }),
                                                    )
                                                    // else
                                                    //   const WaitingOpponentChooseSide()
                                                  ],
                                                );
                                              });
                                        }
          
                                        return const SizedBox();
                                      });
                                });
                          });
                    });
              }),
        ),
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

class Turn extends StatelessWidget {
  final Player player1;
  final Player player2;
  final bool myTurn;
  const Turn({
    super.key,
    required this.player1,
    required this.myTurn,
    required this.player2,
  });

  @override
  Widget build(BuildContext context) {
    return myTurn
        ? Text(
            'Sua vez!',
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : Text(
            'Vez de(a) ${player2.name}',
            style: GoogleFonts.paytoneOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}

class PlayersPanel extends StatelessWidget {
  final Player player1;
  final Player? player2;
  final bool myTurn;
  const PlayersPanel({
    super.key,
    required this.player1,
    required this.myTurn,
    this.player2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: PlayerProfile(player: player1),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
        ),
        Flexible(
          flex: 5,
          child: PlayerProfile(
            player: player2 ??
                Player(
                  id: '',
                  name: 'Aguardando...',
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
              SideButton(
                sideType: SideType.X,
                style: GoogleFonts.carterOne(
                  textStyle: const TextStyle(
                    fontSize: 50,
                    color: Color(0XFFEB1751),
                  ),
                ),
                onPressed: () => chooseASide(SideType.X),
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
              SideButton(
                sideType: SideType.O,
                style: GoogleFonts.carterOne(
                  textStyle: const TextStyle(
                    fontSize: 50,
                    color: Color(0XFFFFD032),
                  ),
                ),
                onPressed: () => chooseASide(SideType.O),
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

class TicTacToeImpl implements TicTacToe {
  TicTacToeImpl({
    this.currentPiece = SideType.X,
  }) {
    board = List.filled(9, SideType.empty);
  }

  @override
  late List<SideType> board;

  @override
  SideType currentPiece;

  @override
  void setSide(SideType side) {
    currentPiece = side;
  }

  @override
  bool canMove(int index) {
    return board[index] == SideType.empty;
  }

  @override
  void move(int index) {
    board[index] = currentPiece;
  }

  @override
  void nextTurn() {}

  @override
  bool verifyWinner() {
    final winners = ['012', '048', '036', '147', '246', '258', '345', '678'];

    for (String win in winners) {
      if (board[int.parse(win[0])] == board[int.parse(win[1])] &&
          board[int.parse(win[1])] == board[int.parse(win[2])] &&
          board[int.parse(win[2])] == currentPiece) {
        return true;
      }
    }

    return false;
  }

  @override
  bool verifyTie() {
    return !board.contains(SideType.empty);
  }
}
