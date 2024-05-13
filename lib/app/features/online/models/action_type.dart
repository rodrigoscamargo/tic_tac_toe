enum ActionType {
  create('create'),
  join('join'),
  leave('leave'),
  info('info'),
  ready('ready'),
  game('game');

  const ActionType(this.name);

  final String name;

  static ActionType? fromString(String value) => switch (value) {
        "create" => create,
        "join" => join,
        "leave" => leave,
        "info" => info,
        "ready" => ready,
        "game" => game,
        _ => null
      };
}
