import 'package:flutter_modular/flutter_modular.dart';
import 'package:tic_tac_toe/app/features/home/home_page.dart';

class HomeModule extends Module {
  HomeModule();

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
  }
}
