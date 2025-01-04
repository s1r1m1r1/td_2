import 'dart:async';

import 'package:bonfire/bonfire.dart';

mixin MixinFutureLoader<T> on Component {
  /// Used to load assets in [onLoad]
  FutureLoader? loader = FutureLoader();
  @override
  Future<void> onLoad() async {
    await loader?.load();
    loader = null;
    return super.onLoad();
  }
}

class FutureToLoad<T> {
  Function(T? value)? callback;
  final FutureOr<T>? future;

  FutureToLoad(this.future, this.callback);
  Future<void> load() async {
    if (future == null) {
      return Future.value();
    }
    callback?.call(await future);
    callback = null;
  }
}

class FutureLoader {
  final List<FutureToLoad> _assets = [];

  void add<T>(FutureToLoad<T> asset) => _assets.add(asset);

  FutureOr<void> load() async {
    for (final element in _assets) {
      await element.load();
    }
    _assets.clear();
  }
}