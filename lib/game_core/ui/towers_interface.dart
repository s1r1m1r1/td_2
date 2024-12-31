import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:td_2/game_core/mixin/mother_pointer_mixin.dart';
import '../tile/stage_map.dart';
import 'draggable_button.dart';

class TowersInterface extends GameInterface {
  TowersInterface(this.mother);
  final MotherPointerMixin mother;
  static const followerWidgetTestId = 'BUTTON';

  @override
  void onMount() async {
    final size = gameRef.size;
    final y = size.y - 64.0;
    debugPrint('game SziZE $size');
    await add(DraggableButtonArena(Vector2(100, 20)));
    await add(DraggableButton(
        position: Vector2(200, y),
        size: Vector2.all(StageMap.tileSize * 2),
        mother: mother));
    await add(DraggableButton(
        position: Vector2(250, y),
        size: Vector2.all(StageMap.tileSize * 2),
        mother: mother));
    await add(DraggableButton(
        position: Vector2(300, y),
        size: Vector2.all(StageMap.tileSize * 2),
        mother: mother));
    await add(DraggableButton(
        position: Vector2(350, y),
        size: Vector2.all(StageMap.tileSize * 2),
        mother: mother));

    super.onMount();
  }
}
