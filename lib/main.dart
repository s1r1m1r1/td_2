import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'game_page.dart';
import 'injector/get_it.config.dart';
import 'utils/logger.dart';
import 'utils/logger_listen.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(watchRecords);
  GetIt.I.init();
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
