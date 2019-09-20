import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/i10n/GmLocalizations.dart';

class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GmLocalizations> load(Locale locale) {
    return SynchronousFuture<GmLocalizations>(
        GmLocalizations(locale.languageCode == 'zh'));
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }
}
