import 'package:bonfire/bonfire.dart';
import '../tile/stage_map.dart';
import 'draggable_button.dart';

class TowersInterface extends GameInterface {
  static const followerWidgetTestId = 'BUTTON';

  @override
  void onMount() async {
    await add(DraggableButtonArena(Vector2(100, 20)));
    await add(DraggableButton(
      position: Vector2(200, 20),
      size: Vector2.all(StageMap.tileSize * 2)
    ));
    await add(DraggableButton(
      position: Vector2(250, 20),
      size: Vector2.all(StageMap.tileSize * 2)
    ));
    await add(DraggableButton(
      position: Vector2(300, 20),
      size: Vector2.all(StageMap.tileSize * 2)
    ));
    await add(DraggableButton(
      position: Vector2(350, 20),
      size: Vector2.all(StageMap.tileSize * 2)
    ));

    super.onMount();
  }
}
