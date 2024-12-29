import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../base/goblin.dart';

typedef ClashCallback = void Function();

enum ClashMode {
  bestOne,
  clashAll,
  explosion,
}

mixin Clash<T> on PositionComponent {
  static const loggerName = 'Clash';
  static final _log = Logger(loggerName);
  T? effect;
  double explosionScan = 0.0;
  final mode = ClashMode.bestOne;

  ClashCallback? clashAlert;

  void radarScan(Iterable<Goblin> targets) {
    if (targets.isEmpty) return;
    if (clashAlert == null) return;
    final t = targets.toList();
    switch (mode) {
      case ClashMode.bestOne:
        _onBestOne(t);
      case ClashMode.clashAll:
        _onClashAll(t);
      case ClashMode.explosion:
        _onClashWithExplosion(t);
    }
  }

  void _onBestOne(List<Goblin> targets) {
    final best = _getBestClash(targets);
    if (best == null) return;
    best.onClash(effect);
    clashAlert?.call();
  }

  void _onClashAll(List<Goblin> targets) {
    final founded = _onScan(targets);
    if (founded.isEmpty) return;
    for (var i in founded) {
      debugPrint(' clash ScanAlert ef: $effect ${i.position}');
      if (!i.isDead) i.onClash(effect);
    }
    clashAlert?.call();
  }

  void _onClashWithExplosion(List<Goblin> targets) {
    final iz = _isClash(targets);
    if (!iz) return;
    final founded = _onScan(targets, explosionScan);
    if (founded.isEmpty) return;
    for (var i in founded) {
      debugPrint(' clash ScanAlert ef: $effect ${i.position}');
      if (!i.isDead) i.onClash(effect);
    }
    clashAlert?.call();
  }

  bool _isClash(List<Goblin> targets) {
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      final pos = target.position;
      final double distance = position.distanceTo(pos);
      final tDist = target.position.distanceTo(target.position + target.size);
      if (distance <= tDist) return true;
    }
    return false;
  }

  Goblin? _getBestClash(List<Goblin> targets) {
    double? bestDistance;
    Goblin? bestTarget;
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      final centerPos = target.position + (target.size / 2);
      final double distance = position.distanceTo(centerPos);
      final collision = target.position.distanceTo(centerPos);
      if (!(distance <= collision)) continue;
      if (bestDistance == null || (distance < bestDistance)) {
        bestTarget = target;
        bestDistance = distance;
      }
    }
    return bestTarget;
  }

  List<Goblin> _onScan(List<Goblin> targets, [double? maxDistance]) {
    final explosions = <Goblin>[];
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      maxDistance ??= target.position.distanceTo(target.position + target.size);
      final pos = target.position;
      final double distance = position.distanceTo(pos);
      if (!(distance <= maxDistance)) continue;
      explosions.add(target);
    }
    return explosions;
  }
}
