import 'game_event.dart';

final staticController = StaticController();

class StaticController {
  StaticController();

  final instructQ = <GameEvent>[];

  void add(GameEvent event) {
    instructQ.add(event);
  }
}
