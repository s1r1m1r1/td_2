// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:td_2/utils/logger.dart';

import '../units/base/goblin.dart';
import '../units/mixin/clash.dart';
import '../units/mixin/radar.dart';
import '../world/grid_component.dart';

void watchRecords(LogRecord rec) {
  // ---- filter --------
  final names = [
    // GridTileComponent.loggerName,
    // Radar.loggerName,
    // Clash.loggerName,
    Goblin.loggerName,
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