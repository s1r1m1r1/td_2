import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../tile/stage_map.dart';
import 'common_sprite_sheet.dart';

class Torch extends GameDecoration {
  Torch(Vector2 position)
      : super.withAnimation(
          animation: CommonSpriteSheet.torchAnimated,
          size: Vector2.all(StageMap.tileSize),
          position: position,
          lightingConfig: LightingConfig(
            radius: StageMap.tileSize * 2,
            blurBorder: StageMap.tileSize,
            color: Colors.deepOrangeAccent.withOpacity(0.3),
            withPulse: true,
            align: Vector2(
                -StageMap.tileSize * 0.25, -StageMap.tileSize * 0.3),
          ),
        );
}
