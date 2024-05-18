enum ActionType {
  create('create'),
  join('join'),
  leave('leave'),
  info('info'),
  choose('choose'),
  start('start'),
  ready('ready'),
  readyToChoose('readyToChoose'),
  game('game');

  const ActionType(this.name);

  final String name;

  static ActionType? fromString(String value) => switch (value) {
        "create" => create,
        "join" => join,
        "leave" => leave,
        "info" => info,
        "choose" => choose,
        "start" => start,
        "ready" => ready,
        "readyToChoose" => readyToChoose,
        "game" => game,
        _ => null
      };
}
