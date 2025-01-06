// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../game_core/controller/astar_controller.dart';
import '../game_core/controller/controller_process.dart';
import '../game_core/controller/timer_process.dart';
import '../game_core/tile/file_fx_controller.dart';
import '../game_core/tile/tile_component.dart';
import 'logger.dart';

void watchRecords(LogRecord rec) {
  // ---- filter --------
  final names = [
    //  TileComponent.loggerName,
    // AstarController.loggerName,
    // Radar.loggerName,
    // Clash.loggerName,
    // EnemySpawnMixin.loggerName,
    // Goblin.loggerName,
    // GameInstruction.loggerName,
    // TileFXController.loggerName,
  ];
  if (!names.contains(rec.loggerName)) return;
  if (rec.stackTrace != null) {
    debugPrintStack(
      stackTrace: rec.stackTrace,
      label: '${rec.level.color}:${rec.loggerName}: $red${rec.message}$reset',
    );
  } else {
    debugPrint('${rec.level.color}:${rec.loggerName}: ${rec.message}');
  }
}
