import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import '../../game_dev.dart';
import '../camera/mother_pointer_mixin.dart';

class TowersInterface extends PositionComponent with HasGameReference<GameDev> {
  TowersInterface(this.mother);
  final MotherPointerMixin mother;
  static const followerWidgetTestId = 'BUTTON';

  @override
  Future<void> onMount() async {
    final size = game.size;
    final y = size.y - 64.0;
    debugPrint('game SiZE $size');
    // await add(DraggableButton(
    //     position: Vector2(200, y),
    //     size: Vector2.all(StageMap.tileSize * 2),
    //     mother: mother));
    // await add(DraggableButton(
    //     position: Vector2(250, y),
    //     size: Vector2.all(StageMap.tileSize * 2),
    //     mother: mother));
    // await add(DraggableButton(
    //     position: Vector2(300, y),
    //     size: Vector2.all(StageMap.tileSize * 2),
    //     mother: mother));
    // await add(DraggableButton(
    //     position: Vector2(350, y),
    //     size: Vector2.all(StageMap.tileSize * 2),
    //     mother: mother));

    super.onMount();
  }
}
