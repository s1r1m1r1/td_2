import 'package:bonfire/bonfire.dart';
import 'stage_map.dart';
import 'common_sprite_sheet.dart';

class Spikes extends GameDecoration with Sensor<Attackable> {
  Spikes(Vector2 position, {Vector2? size})
      : super.withSprite(
          sprite: CommonSpriteSheet.spikesSprite,
          position: position,
          size: size ?? Vector2.all(StageMap.tileSize / 1.5),
        ) {
    setSensorInterval(500);
  }

  @override
  void onContact(Attackable component) {
    if (component is Player) {
      component.handleAttack(AttackOriginEnum.ENEMY, 10, 1);
    } else {
      component.handleAttack(AttackOriginEnum.PLAYER_OR_ALLY, 10, 1);
    }
  }
}
