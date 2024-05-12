import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/game/game_page.dart';

class GameModule extends Module {
  GameModule();

  @override
  void routes(RouteManager r) {
    r.child('/vis-a-vis', child: (_) => const GamePage());
    r.child('/ai', child: (_) => const GamePage());
    r.child('/online', child: (_) => const GamePage());
  }
}
