import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'game_manual_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrintStack(stackTrace: stack, label: 'PlatformDispatcher');
    return true;
  };

  runApp(const MaterialApp(
    home: GameManualMap(),
  ));
}
