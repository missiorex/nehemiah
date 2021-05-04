// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:campaign_repository/campaign_repository.dart';

abstract class CampaignRepository {
  //Video Stream
  Future<void> addNewCampaign(Campaign campaign);

  Future<void> deleteCampaign(Campaign campaign);

  Stream<List<Campaign>> campaigns();

  Future<void> updateCampaign(Campaign campaign);

  Future<void> saveCampaigns(List<Campaign> campaigns);
}
