import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final _log = Logger(MixinClash.loggerName);

enum ClashMode {
  bestOne,
  collision,
}

mixin MixinClashTarget on PositionComponent {
  // abstract
  onClash(dynamic value);
}

mixin MixinClash on PositionComponent {
  static const loggerName = 'Clash';
  abstract final dynamic effect;
  abstract final ClashMode mode;
  // abstract
  void clashAlert();
  bool _clashActive = true;
  void disableClash() {
    _clashActive = false;
  }

  void radarScan(Iterable<MixinClashTarget> targets) {
    if (!_clashActive) return;
    if (targets.isEmpty) return;
    // if (clashAlert == null) return;
    final t = targets.toList();
    switch (mode) {
      case ClashMode.bestOne:
        _onBestOne(t);
      case ClashMode.collision:
        _onClashAll(t);
    }
  }

  void _onBestOne(List<MixinClashTarget> targets) {
    final best = _getBestClash(targets);
    if (best == null) return;
    best.onClash(effect);
    clashAlert();
  }

  void _onClashAll(List<MixinClashTarget> targets) {
    final founded = _onCollision(targets);
    if (founded.isEmpty) return;
    debugPrint('-- FOUNDED ${founded.length}');
    for (var i in founded) {
      i.onClash(effect);
    }

    clashAlert.call();
  }

  MixinClashTarget? _getBestClash(List<MixinClashTarget> targets) {
    double? bestDistance;
    MixinClashTarget? bestTarget;
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

  List<MixinClashTarget> _onCollision(List<MixinClashTarget> targets) {
    final collisions = <MixinClashTarget>[];
    final rect = toRect();
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      final contains = rect.overlapComponent(target);
      if (!contains) continue;
      collisions.add(target);
    }
    return collisions;
  }
}
