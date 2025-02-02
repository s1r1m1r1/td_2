import 'package:flame/components.dart';

import '../../other/priority.dart';

class CursorComponent extends SpriteComponent with HasVisibility {
  CursorComponent({super.position, super.sprite,super.size,super.scale});

  @override
  int priority = Priority.overAll;
}
