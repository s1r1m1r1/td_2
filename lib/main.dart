import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'bloc/observer/app_bloc_observer.dart';
import 'flutter_module/app/app.dart';
import 'injector/get_it.config.dart';
import 'utils/logger.dart';
import 'utils/logger_listen.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(watchRecords);
  GetIt.I.init();
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrintStack(
      stackTrace: stack,
      label: '${red}PlatformDispatcher$reset$error',
    );
    return true;
  };

  FlutterError.onError = (details) {
    debugPrintStack(
      stackTrace: details.stack,
      label: '${red}FlutterError.onError$reset${details.exception}',
    );
  };
  Bloc.observer = AppBlocObserver();

  runApp(
    const App(),
  );
}
