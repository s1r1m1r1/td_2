import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:td_2/utils/logger.dart';
import 'package:td_2/utils/logger_listen.dart';
import 'game_page.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(watchRecords);

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrintStack(stackTrace: stack, label: '${red}PlatformDispatcher$reset');
    return true;
  };

  FlutterError.onError = (details) {
    debugPrintStack(
        stackTrace: details.stack, label: '${red}FlutterError.onError $reset');
  };

  runApp(const MaterialApp(
    home: GamePage(),
  ));
}
