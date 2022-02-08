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

  /// `+ Add plant`
  String get addPlant {
    return Intl.message(
      '+ Add plant',
      name: 'addPlant',
      desc: '',
      args: [],
    );
  }

  /// `Add new plant`
  String get addNewPlant {
    return Intl.message(
      'Add new plant',
      name: 'addNewPlant',
      desc: '',
      args: [],
    );
  }

  /// `Garden`
  String get appName {
    return Intl.message(
      'Garden',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `No plants added`
  String get noPlants {
    return Intl.message(
      'No plants added',
      name: 'noPlants',
      desc: '',
      args: [],
    );
  }

  /// `Seach for a plant`
  String get plantsSearchText {
    return Intl.message(
      'Seach for a plant',
      name: 'plantsSearchText',
      desc: '',
      args: [],
    );
  }

  /// `What is the name of a plant?`
  String get nameOfPlantQuestion {
    return Intl.message(
      'What is the name of a plant?',
      name: 'nameOfPlantQuestion',
      desc: '',
      args: [],
    );
  }

  /// `When the plant was planted?`
  String get plantDateQuestion {
    return Intl.message(
      'When the plant was planted?',
      name: 'plantDateQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Choose plant type`
  String get choosePlantType {
    return Intl.message(
      'Choose plant type',
      name: 'choosePlantType',
      desc: '',
      args: [],
    );
  }

  /// `Clear form`
  String get clearForm {
    return Intl.message(
      'Clear form',
      name: 'clearForm',
      desc: '',
      args: [],
    );
  }

  /// `Edit plant`
  String get editPlant {
    return Intl.message(
      'Edit plant',
      name: 'editPlant',
      desc: '',
      args: [],
    );
  }

  /// `Save plant`
  String get savePlant {
    return Intl.message(
      'Save plant',
      name: 'savePlant',
      desc: '',
      args: [],
    );
  }

  /// `Inserted successfully`
  String get insertedSuccessfully {
    return Intl.message(
      'Inserted successfully',
      name: 'insertedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get updatedSuccessfully {
    return Intl.message(
      'Updated successfully',
      name: 'updatedSuccessfully',
      desc: '',
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
