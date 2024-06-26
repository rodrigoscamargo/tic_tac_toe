import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/offline/offline_game_module.dart';
import 'package:tic_tac_toe/app/features/home/home_module.dart';
import 'package:tic_tac_toe/app/features/online/online_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/game', module: OfflineGameModule());
    r.module('/online', module: OnlineModule());
  }
}
