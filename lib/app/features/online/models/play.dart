class Play {
  int position;

  Play({
    required this.position,
  });

  static fromJson(Map<String, dynamic> json) {
    return Play(
      position: json['position'],
    );
  }
}
