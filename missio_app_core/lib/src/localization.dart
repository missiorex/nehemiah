// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'localizations/messages_all.dart';

class MainLocalizations {
  MainLocalizations(this.locale);

  final Locale locale;

  static Future<MainLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return MainLocalizations(locale);
    });
  }

  static MainLocalizations of(BuildContext context) {
    return Localizations.of<MainLocalizations>(context, MainLocalizations);
  }

  String get todos => Intl.message(
        'Todos',
        name: 'todos',
        args: [],
        locale: locale.toString(),
      );

  String get campaigns => Intl.message(
        'Campaigns',
        name: 'campaigns',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newTodoHint => Intl.message(
        'What needs to be done?',
        name: 'newTodoHint',
        args: [],
        locale: locale.toString(),
      );

  String get newCampaignHint => Intl.message(
        'Title of your new campaign?',
        name: 'newCampaignHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addCampaign => Intl.message(
        'Add Campaign',
        name: 'addCampaign',
        args: [],
        locale: locale.toString(),
      );

  String get editCampaign => Intl.message(
        'Edit Campaign',
        name: 'editCampaign',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterCampaigns => Intl.message(
        'Filter Campaigns',
        name: 'filterCampaigns',
        args: [],
        locale: locale.toString(),
      );

  String get deleteCampaign => Intl.message(
        'Delete Campaign',
        name: 'deleteCampaign',
        args: [],
        locale: locale.toString(),
      );

  String get campaignDetails => Intl.message(
        'Campaign Details',
        name: 'campaignDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyCampaignError => Intl.message(
        'Please enter some text',
        name: 'emptyCampaignError',
        args: [],
        locale: locale.toString(),
      );

  String get descriptionHint => Intl.message(
        'Additional Details of your campaign',
        name: 'descriptionHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedCampaigns => Intl.message(
        'Completed Campaigns',
        name: 'completedCampaigns',
        args: [],
        locale: locale.toString(),
      );

  String get activeCampaigns => Intl.message(
        'Active Campaigns',
        name: 'activeCampaigns',
        args: [],
        locale: locale.toString(),
      );

  String campaignDeleted(String title) => Intl.message(
        'Deleted "$title"',
        name: 'todoDeleted',
        args: [title],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteCampaignConfirmation => Intl.message(
        'Delete this campaign?',
        name: 'deleteCampaignConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class MainLocalizationsDelegate
    extends LocalizationsDelegate<MainLocalizations> {
  @override
  Future<MainLocalizations> load(Locale locale) =>
      MainLocalizations.load(locale);

  @override
  bool shouldReload(MainLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
