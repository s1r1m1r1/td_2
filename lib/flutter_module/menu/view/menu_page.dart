import 'dart:ui';

import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/audio/audio_cubit.dart';
import '../../../game_page.dart';
import '../../../generated/assets.gen.dart';

class MenuPage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const MenuPage._(),
    );
  }

  const MenuPage._();

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late final AnimationController animController;
  late final List<AnimationController> anims;
  late final List<Interval> intervals;
  late final Bgm bgm;
  late final AudioPlayer effectPlayer;

  @override
  void initState() {
    super.initState();
    bgm = context.read<AudioCubit>().bgm;
    effectPlayer = context.read<AudioCubit>().effectPlayer;
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    intervals = const <Interval>[
      Interval(0.0, 0.35),
      Interval(0.2, 0.55),
      Interval(0.35, 0.7),
      Interval(0.5, 0.85),
      Interval(0.75, 1.0),
    ];
    anims = List.generate(5, (_) => AnimationController(vsync: this));

    animController.addListener(_updateAnim);
    animController.forward();
    startBgmMusic();
  }

  void startBgmMusic() {
    bgm.initialize();
    bgm.play(Assets.audio.music.zanderNoriegaTheorem199Variant);
  }

  void playOne() {
    effectPlayer.play(
      AssetSource(
        Assets.audio.sfx.fire2,
      ),
    );
  }

  void playTwo() {
    effectPlayer.play(
      AssetSource(
        Assets.audio.sfx.fire1,
      ),
    );
  }

  void _updateAnim() {
    for (var i = 0; i < intervals.length; i++) {
      final v = intervals[i].transform(animController.value);
      if (v != 0 && !(v == 1 && anims[i].value == 1.0)) {
        anims[i].value = v;
      }
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              _Button(
                animation: anims[0],
                onTap: () {
                  debugPrint('FX');
                  playOne();
                },
              ),
              _Button(
                animation: anims[1],
                onTap: () {
                  playTwo();
                  Navigator.of(context).push(
                    GamePage.route(),
                  );
                },
              ),
              _Button(
                animation: anims[2],
                onTap: () {
                  playTwo();
                },
              ),
              _Button(
                animation: anims[3],
                onTap: () {
                  playTwo();
                },
              ),
              _Button(
                animation: anims[4],
                onTap: () {
                  playTwo();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatefulWidget {
  const _Button({
    required this.animation,
    required this.onTap,
  });
  final VoidCallback onTap;
  final Animation<double> animation;

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> with SingleTickerProviderStateMixin {
  late final AnimationController pressController;
  late final WidgetStatesController statesController;

  @override
  void initState() {
    super.initState();
    pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    statesController = WidgetStatesController();
    statesController.addListener(onStates);
  }

  void onStates() {
    if (!statesController.value.contains(WidgetState.pressed)) {
      pressController.stop();
      pressController.reverse();
      setState(() {});
    }
  }

  @override
  void dispose() {
    statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pressController,
      builder: (_, __) {
        return ListenableBuilder(
          listenable: widget.animation,
          builder: (context, _) {
            final anim = widget.animation.value;
            final pressAnim = pressController.value;
            final introWidth = lerpDouble(50, 400, anim)!;
            final pressWidth = lerpDouble(0, 100, pressAnim)!;
            final maxWidth = introWidth + pressWidth;

            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: maxWidth,
                height: 60,
                child: Ink(
                  color: Colors.green,
                  child: InkWell(
                    statesController: statesController,
                    onTapDown: (details) {
                      pressController.stop();
                      pressController.forward();
                    },
                    onTapUp: (_) {
                      debugPrint('Button pressed');
                      widget.onTap();
                    },
                    child: Text('TExt'),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
