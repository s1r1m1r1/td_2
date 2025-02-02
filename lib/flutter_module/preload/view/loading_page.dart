import 'package:flame/cache.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';

import '../../menu/view/menu_page.dart';
import '../cubit/preload_cubit.dart';
import '../widget/animated_progress.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreloadCubit(
        Images(prefix: ''),
        AudioCache(prefix: ''),
      )..loadSequentially(),
      child: const LoadingView(),
    );
  }
}

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  Future<void> onPreloadComplete(BuildContext context) async {
    final navigator = Navigator.of(context);
    await Future<void>.delayed(AnimatedProgress.intrinsicAnimationDuration);
    if (!mounted) {
      return;
    }
    await navigator.pushReplacement<void, void>(MenuPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreloadCubit, PreloadState>(
      listenWhen: (prevState, state) =>
          !prevState.isComplete && state.isComplete,
      listener: (context, state) => onPreloadComplete(context),
      child: const Scaffold(
        body: Center(
          child: _LoadingInternal(),
        ),
      ),
    );
  }
}

class _LoadingInternal extends StatelessWidget {
  const _LoadingInternal();

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;

    return BlocBuilder<PreloadCubit, PreloadState>(
      builder: (context, state) {
        final loadingLabel =
            S.of(context).loadingPhaseLabel(state.currentLabel);

        final loadingMessage = S.of(context).loading(loadingLabel);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedProgress(
                progress: state.progress,
              ),
            ),
            Text(
              loadingMessage,
              style: primaryTextTheme.bodySmall!.copyWith(
                color: const Color(0xFF2A48DF),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        );
      },
    );
  }
}
