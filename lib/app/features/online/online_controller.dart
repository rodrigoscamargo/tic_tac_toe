import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';
import 'package:tic_tac_toe/app/features/online/models/action_type.dart';
import 'package:tic_tac_toe/app/features/online/models/message.dart';
import 'package:tic_tac_toe/app/features/online/models/params.dart';
import 'package:tic_tac_toe/app/features/online/models/play.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OnlineController {
  final WebSocketChannel ws;
  final TicTacToe ticTacToe;

  OnlineController({
    required this.ws,
    required this.ticTacToe,
  }) {
    _initWebSocket();
  }

  final room = ValueNotifier<String?>(null);
  final player = ValueNotifier<Player?>(null);
  final opponent = ValueNotifier<Player?>(null);
  final board = ValueNotifier<List<SideType>>(List.filled(9, SideType.empty));
  final start = ValueNotifier<bool>(false);
  final ready = ValueNotifier<bool>(false);
  final chooseSide = ValueNotifier<bool>(false);
  final wait = ValueNotifier<bool>(false);

  void _initWebSocket() {

    ws.stream.listen((message) {
      debugPrint('message: "$message"');

      Message messageData = Message.fromJson(jsonDecode(message));

      switch (messageData.type) {
        case ActionType.create:
        case ActionType.join:
        case ActionType.leave:
        case ActionType.choose:
        case ActionType.info:
          _info(messageData);
        case ActionType.game:
          _game(messageData.params!.play!);
        case ActionType.ready:
          _ready(messageData);
        case ActionType.readyToChoose:
          _readyToChoose(messageData);
        case ActionType.start:
          _start(messageData);
        case ActionType.gameover:
          _gameover();
        case ActionType.restart:
          _restart();
      }
    });
  }

  void _game(Play play) {
    board.value[play.position] = opponent.value!.piece!;
    ticTacToe.board = board.value;

    if (ticTacToe.verifyWinner()) {}
    if (ticTacToe.verifyTie()) {}

    wait.value = false;
  }

  void _info(Message message) {
    room.value = message.params!.room;
  }

  void _ready(Message message) {
    ready.value = true;
    wait.value = true;
    opponent.value = message.params!.player;
  }

  void _readyToChoose(Message message) {
    ready.value = true;
    chooseSide.value = true;
    opponent.value = message.params!.player;
  }

  void _start(Message message) {
    opponent.value = message.params!.player;
    player.value = player.value!.copyWith(
      piece:
          message.params!.player!.piece == SideType.O ? SideType.X : SideType.O,
    );
    ticTacToe.setSide(
        chooseSide.value ? player.value!.piece! : opponent.value!.piece!);
    start.value = true;
  }

  void _gameover() {}
  
  void _restart() {}

  void makeMove(int position) {
    board.value[position] = player.value!.piece!;
    ticTacToe.board = board.value;
    if (ticTacToe.verifyWinner()) {}
    if (ticTacToe.verifyTie()) {}
    ws.sink.add(
      jsonEncode({
        'type': 'game',
        'params': {
          'room': room.value,
          'player': {
            'id': player.value!.id,
          },
          'play': {
            'position': position,
          }
        }
      }),
    );
    wait.value = true;
  }

  void createRoom() async {
    ws.sink.add(
      jsonEncode(
        Message(
          type: ActionType.create,
          params: Params(
            room: room.value,
            player: player.value,
          ),
        ).toJson(),
      ),
    );
  }

  void joinRoom() async {
    ws.sink.add(
      jsonEncode(
        Message(
          type: ActionType.join,
          params: Params(
            room: room.value,
            player: player.value,
          ),
        ).toJson(),
      ),
    );
  }

  void chooseASide(SideType type) {
    player.value = player.value!.copyWith(piece: type);
    ws.sink.add(
      jsonEncode(
        Message(
          type: ActionType.choose,
          params: Params(
            room: room.value,
            player: player.value,
          ),
        ).toJson(),
      ),
    );
  }
}
