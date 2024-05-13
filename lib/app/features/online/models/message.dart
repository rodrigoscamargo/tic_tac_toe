import 'package:tic_tac_toe/app/features/online/models/action_type.dart';
import 'package:tic_tac_toe/app/features/online/models/params.dart';

class Message {
  ActionType type;
  Params? params;

  Message({required this.type, this.params});

  static fromJson(Map<String, dynamic> json) {
    return Message(
        type: ActionType.fromString(json['type'])!,
        params:
            json['params'] != null ? Params.fromJson(json['params']) : null);
  }

  Map toJson() {
    return {
      "type": type.name,
      "params": {"room": "room"}
    };
  }
}
