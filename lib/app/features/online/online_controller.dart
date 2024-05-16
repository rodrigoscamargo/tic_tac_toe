import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/features/game/game_controller.dart';
import 'package:tic_tac_toe/app/features/online/models/action_type.dart';
import 'package:tic_tac_toe/app/features/online/models/message.dart';
import 'package:tic_tac_toe/app/features/online/models/play.dart';
import 'package:web_socket_client/web_socket_client.dart';

class OnlineController {
  final WebSocket ws;
  final TicTacToe ticTacToe;

  OnlineController({
    required this.ws,
    required this.ticTacToe,
  }) {
    initWebSocket();
  }

  final room = ValueNotifier<String?>(null);
  final board = ValueNotifier<List<PieceType>>(List.filled(9, PieceType.empty));
  final opponent = ValueNotifier<String?>(null);
  final ready = ValueNotifier<bool>(false);
  final wait = ValueNotifier<bool>(false);

  String? player;

  void initWebSocket() {
    debugPrint("Connecting to websocket");

    ws.messages.listen((message) {
      debugPrint('message: "$message"');

      Message messageData = Message.fromJson(jsonDecode(message));

      switch (messageData.type) {
        case ActionType.create:
        // TODO: Handle this case.
        case ActionType.join:
        // TODO: Handle this case.
        case ActionType.leave:
        // TODO: Handle this case.
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
          }
      }
    });
  }

  void game(Play play) {
    ticTacToe.move(play.position);

    wait.value = false;
  }

  void makeMove(int position) {
    ws.send(
      jsonEncode({
        'type': 'game',
        'params': {
          'room': room.value,
          'play': {
            'position': position,
          }
        }
      }),
    );
    wait.value = true;
  }

  Future<void> createRoom() async {
    ws.send(
      jsonEncode(Message(type: ActionType.create).toJson()),
    );
  }
}
