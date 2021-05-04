import 'dart:async';

import 'package:flutter/material.dart';

class CampaignLocalizations {
  static CampaignLocalizations of(BuildContext context) {
    return Localizations.of<CampaignLocalizations>(
      context,
      CampaignLocalizations,
    );
  }

  String get appTitle => "Prayer Campaigns";
}

class CampaignLocalizationsDelegate
    extends LocalizationsDelegate<CampaignLocalizations> {
  @override
  Future<CampaignLocalizations> load(Locale locale) =>
      Future(() => CampaignLocalizations());

  @override
  bool shouldReload(CampaignLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}
