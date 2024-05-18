import 'package:tic_tac_toe/app/features/game/game_controller.dart';

class Player {
  final String id;
  final String name;
  final SideType? piece;

  Player({
    required this.id,
    required this.name,
    this.piece,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json['id'],
        name: json['name'],
        piece: SideType.fromString(json['piece']));
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'piece': piece?.side,
    };
  }
}
