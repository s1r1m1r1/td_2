import 'package:flame/components.dart';

import '../tile/floor_fx_controller.dart';
import '../unit/enemy/enemy.dart';

/// write comment for every
extension WorldExt on World {
  List<Enemy> get enemies =>
      children.query<Enemy>().where((i) => !i.isRemoving).toList();

  FloorFXController? get floorFXController =>
      children.query<FloorFXController>().firstOrNull;
}
