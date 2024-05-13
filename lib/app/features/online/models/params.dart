class Params {
  final String room;
  final int noClients;

  Params({required this.room, required this.noClients});

  static fromJson(Map<String, dynamic> json) {
    return Params(
      room: json['room'],
      noClients: json['no-clients'],
    );
  }
}
