// import 'dart:ui' show Color;

// import 'package:bonfire/bonfire.dart' show TextDamageComponent;
// import 'package:bonfire/util/text_damage_component.dart'
//     show DirectionTextDamage;
// import 'package:flame/components.dart';
// import 'package:flutter/painting.dart' show TextStyle;

// import '../../other/stage_map.dart';

// mixin MixinFxDamage on PositionComponent {
//   /// Add in the game a text with animation representing damage received
//   PositionComponent fxDamage(
//     double damage, {
//     Vector2? position,
//     TextStyle? config,
//     double initVelocityVertical = -5,
//     double initVelocityHorizontal = 1,
//     double gravity = 0.5,
//     double maxDownSize = 20,
//     DirectionTextDamage direction = DirectionTextDamage.RANDOM,
//     bool onlyUp = false,
//   }) {
//     return TextDamageComponent(
//       damage.toInt().toString(),
//       position ?? Vec2.zero,
//       config: config ??
//           const TextStyle(
//             fontSize: 14,
//             color: Color(0xFFFFFFFF),
//           ),
//       initVelocityVertical: initVelocityVertical,
//       initVelocityHorizontal: initVelocityHorizontal,
//       gravity: gravity,
//       direction: direction,
//       onlyUp: onlyUp,
//       maxDownSize: maxDownSize,
//     );
//   }
// }
