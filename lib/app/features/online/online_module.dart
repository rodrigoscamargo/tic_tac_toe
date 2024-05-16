import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/game/game_controller.dart';
import 'package:tic_tac_toe/app/features/game/game_page.dart';
import 'package:tic_tac_toe/app/features/online/online_controller.dart';
import 'package:tic_tac_toe/app/features/online/online_game_page.dart';
import 'package:tic_tac_toe/app/features/online/online_page.dart';
import 'package:web_socket_client/web_socket_client.dart';

class OnlineModule extends Module {
  @override
  void binds(Injector i) {
    i.add(OnlineController.new);
    i.add<TicTacToe>(TicTacToeImpl.new);
    i.add(
      () => WebSocket(
        kIsWeb
            ? Uri.parse('ws://localhost:1234')
            : Uri.parse('ws://10.0.2.2:1234'),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const OnlinePage());
    r.child('/game', child: (_) => const OnlineGamePage());
  }
}
