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
    initWebSocket();
  }

  final room = ValueNotifier<String?>(null);
  final player = ValueNotifier<Player?>(null);
  final opponent = ValueNotifier<Player?>(null);
  final board = ValueNotifier<List<SideType>>(List.filled(9, SideType.empty));
  final start = ValueNotifier<bool>(false);
  final ready = ValueNotifier<bool>(false);
  final chooseSide = ValueNotifier<bool>(false);
  final wait = ValueNotifier<bool>(false);

  void initWebSocket() {
    debugPrint("Connecting to websocket");

    ws.stream.listen((message) {
      debugPrint('message: "$message"');

      Message messageData = Message.fromJson(jsonDecode(message));

      switch (messageData.type) {
        case ActionType.create:
        case ActionType.join:
        case ActionType.leave:
        case ActionType.choose:
        case ActionType.info:
          {
            room.value = messageData.params!.room;
          }

        case ActionType.game:
          {
            game(messageData.params!.play!);
          }
        case ActionType.ready:
          {
            ready.value = true;
            wait.value = true;
            opponent.value = messageData.params!.player;
          }
        case ActionType.readyToChoose:
          {
            ready.value = true;
            chooseSide.value = true;
            opponent.value = messageData.params!.player;
          }
        case ActionType.start:
          {
            opponent.value = messageData.params!.player;
            player.value = player.value!.copyWith(
              piece: messageData.params!.player!.piece == SideType.O
                  ? SideType.X
                  : SideType.O,
            );
            ticTacToe.setSide(chooseSide.value
                ? player.value!.piece!
                : opponent.value!.piece!);
            start.value = true;
          }
      }
    });
  }

  void game(Play play) {
    board.value[play.position] = opponent.value!.piece!;
    ticTacToe.board = board.value;

    if (ticTacToe.verifyWinner()) {}
    if (ticTacToe.verifyTie()) {}

    wait.value = false;
  }

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
