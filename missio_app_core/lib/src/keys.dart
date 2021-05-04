// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class CampaignKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addCampaignFab = Key('__addCampaignFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Todos
  static const campaignList = Key('__campaignList__');
  static const campaignsLoading = Key('__campaignsLoading__');
  static final campaignItem = (String id) => Key('CampaignItem__${id}');
  static final campaignItemCheckbox =
      (String id) => Key('CampaignItem__${id}__Checkbox');
  static final campaignItemTitle =
      (String id) => Key('CampaignItem__${id}__Title');
  static final campaignItemDescription =
      (String id) => Key('CampaignItem__${id}__Description');

  // Tabs
  static const tabs = Key('__tabs__');
  static const campaignTab = Key('__campaignTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editCampaignFab = Key('__editCampaignFab__');
  static const deleteCampaignButton = Key('__deleteCampaignFab__');
  static const campaignDetailsScreen = Key('__campaignDetailsScreen__');
  static final detailsCampaignItemCheckbox = Key('DetailsCampaign__Checkbox');
  static final detailsCampaignItemTitle = Key('DetailsCampaign__Title');
  static final detailsCampaignItemDescription = Key('DetailsTodo__Description');

  // Add Screen
  static const addCampaignScreen = Key('__addCampaignScreen__');
  static const saveNewCampaign = Key('__saveNewCampaign__');
  static const titleField = Key('__titleField__');
  static const descriptionField = Key('__descriptionField__');

  // Edit Screen
  static const editCampaignScreen = Key('__editCampaignScreen__');
  static const saveCampaignFab = Key('__saveCampaignFab__');

  static final extraActionsPopupMenuButton =
      const Key('__extraActionsPopupMenuButton__');
  static final extraActionsEmptyContainer =
      const Key('__extraActionsEmptyContainer__');
  static final filteredCampaignsEmptyContainer =
      const Key('__filteredCampaignsEmptyContainer__');
  static final statsLoadInProgressIndicator =
      const Key('__statsLoadingIndicator__');
  static final emptyStatsContainer = const Key('__emptyStatsContainer__');
  static final emptyDetailsContainer = const Key('__emptyDetailsContainer__');
  static final detailsScreenCheckBox = const Key('__detailsScreenCheckBox__');
}
