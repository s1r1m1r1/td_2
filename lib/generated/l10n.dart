// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `{count, plural, =1{You have tapped the unicorn 1 time} other{You have tapped the unicorn {count} times}}`
  String counterText(int count) {
    return Intl.plural(
      count,
      one: 'You have tapped the unicorn 1 time',
      other: 'You have tapped the unicorn $count times',
      name: 'counterText',
      desc: 'Text for the counter component',
      args: [count],
    );
  }

  /// `Loading {label}...`
  String loading(String label) {
    return Intl.message(
      'Loading $label...',
      name: 'loading',
      desc: 'Text for the loading page',
      args: [label],
    );
  }

  /// `{loadingPhase, select, audio{Delightful music} images{Beautiful scenery} other{ }}`
  String loadingPhaseLabel(Object loadingPhase) {
    return Intl.select(
      loadingPhase,
      {
        'audio': 'Delightful music',
        'images': 'Beautiful scenery',
        'other': ' ',
      },
      name: 'loadingPhaseLabel',
      desc: 'Loading phases',
      args: [loadingPhase],
    );
  }

  /// `Start the Very Good Game`
  String get startVeryGoodGame {
    return Intl.message(
      'Start the Very Good Game',
      name: 'startVeryGoodGame',
      desc: 'The initial start button of the game application',
      args: [],
    );
  }

  /// `{{project_name.titleCase()}}`
  String get titleAppBarTitle {
    return Intl.message(
      '{{project_name.titleCase()}}',
      name: 'titleAppBarTitle',
      desc: 'Text shown in the AppBar of the Title Page',
      args: [],
    );
  }

  /// `Start`
  String get titleButtonStart {
    return Intl.message(
      'Start',
      name: 'titleButtonStart',
      desc: 'Text shown in the start Button of the Title Page',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
