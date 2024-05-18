import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_controller.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_page.dart';
import 'package:tic_tac_toe/app/features/online/online_controller.dart';
import 'package:tic_tac_toe/app/features/online/online_game_page.dart';
import 'package:tic_tac_toe/app/features/online/pages/create_page.dart';
import 'package:tic_tac_toe/app/features/online/pages/join_page.dart';
import 'package:tic_tac_toe/app/features/online/pages/online_page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_client/web_socket_client.dart';

class OnlineModule extends Module {
  @override
  void binds(Injector i) {
    i.add(OnlineController.new);
    i.add<TicTacToe>(TicTacToeImpl.new);
    i.add(
      () => WebSocketChannel.connect(
        kIsWeb
            ? Uri.parse('ws://localhost:1235')
            : Uri.parse('ws://10.0.2.2:1235'),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const OnlinePage());
    r.child('/create', child: (_) => const CreatePage());
    r.child('/join', child: (_) => const JoinPage());
    r.child(
      '/game',
      child: (_) => OnlineGamePage(
        player: r.args.data['player'],
        room: r.args.data['room'],
      ),
    );
  }
}
