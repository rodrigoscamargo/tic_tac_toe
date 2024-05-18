import 'package:tic_tac_toe/app/features/online/models/play.dart';
import 'package:tic_tac_toe/app/features/online/models/player.dart';

class Params {
  final String? room;
  final Player? player;
  final Play? play;

  Params({
    required this.room,
    this.player,
    this.play,
  });

  static fromJson(Map<String, dynamic> json) {
    return Params(
      room: json['room'],
      player: json['player'],
      //play: json['play'] != null ? Play.fromJson(json['play']) : null,
    );
  }

  toJson(){
    return {
      'room': room, 
      'player': player?.toJson()
    };
  }
}
