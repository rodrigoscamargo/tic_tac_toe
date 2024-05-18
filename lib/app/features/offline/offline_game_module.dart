import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_page.dart';

class OfflineGameModule extends Module {
  OfflineGameModule();

  @override
  void routes(RouteManager r) {
    r.child('/vis-a-vis', child: (_) => const OfflineGamePage());
    r.child('/ai', child: (_) => const OfflineGamePage());
    r.child('/online', child: (_) => const OfflineGamePage());
  }
}
