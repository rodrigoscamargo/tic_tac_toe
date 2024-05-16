import 'package:tic_tac_toe/app/features/online/models/play.dart';

class Params {
  final String room;
  final int? noClients;
  final Play? play;

  Params({
    required this.room,
    this.noClients,
    this.play,
  });

  static fromJson(Map<String, dynamic> json) {
    return Params(
      room: json['room'],
      noClients: json['no-clients'],
      play: json['play'] != null ? Play.fromJson(json['play']) : null,
    );
  }
}
