// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:td_2/controller/astar_mixin.dart';
import 'package:td_2/controller/controller_process.dart';
import 'package:td_2/tile/file_fx_controller.dart';
import 'package:td_2/utils/logger.dart';

import '../controller/enemy_spawn_mixin.dart';
import '../unit/base/goblin.dart';
import '../unit/mixin/clash.dart';
import '../unit/mixin/radar.dart';
import '../tile/tile_component.dart';

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
