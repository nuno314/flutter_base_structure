import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import 'res/en.dart';
import 'res/vi.dart';

typedef TranslateCallback = String Function(String key, {List<dynamic> params});

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  const SLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => LocaleKey.isSupported(locale.languageCode);

  @override
  Future<S> load(Locale locale) async {
    final localeName =
        (locale.countryCode == null || locale.countryCode?.isEmpty == true)
            ? locale.languageCode
            : LocaleKey.vn;

    final localizations = S(localeName);
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(SLocalizationsDelegate old) => false;
}

class S {
  S(this.localeName);

  static const LocalizationsDelegate<S> delegate = SLocalizationsDelegate();

  static const supportedLocales = [
    Locale(LocaleKey.vn),
    Locale(LocaleKey.en),
  ];

  Future<bool> load(Locale locale) async {
    final Map<String, dynamic> _result = _getResData();

    _sentences = {};
    _result.forEach((String key, dynamic value) {
      _sentences?[key] = value.toString();
    });

    return true;
  }

  // ignore: prefer_constructors_over_static_methods
  static S of(BuildContext? context) {
    if (context == null) {
      return S(null);
    }
    return Localizations.of<S>(context, S) ?? S(null);
  }

  final String? localeName;
  Map<String, String>? _sentences;

  String translate(String key, {List<dynamic> params = const []}) {
    if (localeName == null) {
      if (en_res[key] == null) {
        return key;
      }
      return sprintf(en_res[key]!, params);
    }
    if (_sentences?[key] == null) {
      return key;
    }
    return sprintf(_sentences![key]!, params);
  }

  Map<String, String> _getResData() {
    switch (localeName) {
      case LocaleKey.en:
        return en_res;
      case LocaleKey.vn:
        return vi_res;
      default:
        return {};
    }
  }
}

class LocaleKey {
  static const String en = 'en';
  static const String vn = 'vi';

  static bool isSupported(String locale) {
    return locale == en || locale == vn;
  }
}

extension LocaleExt on String {
  bool get isVn => this == LocaleKey.vn;
}
