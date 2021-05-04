// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'entities/entities.dart';

class FirebaseCampaignRepository implements CampaignRepository {
  final campaignCollection = FirebaseFirestore.instance.collection('campaigns');
  final priorityCampaignsCollection = FirebaseFirestore.instance
      .collection('campaigns')
      .where('isPriority', isEqualTo: true);

  @override
  Future<void> addNewCampaign(Campaign campaign) {
    return campaignCollection.add(campaign.toEntity().toDocument());
  }

  @override
  Future<void> deleteCampaign(Campaign campaign) async {
    return campaignCollection.doc(campaign.id).delete();
  }

  @override
  Future<void> updateCampaign(Campaign update) {
    return campaignCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }

  @override
  Stream<List<Campaign>> campaigns() {
    return campaignCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Campaign.fromEntity(CampaignEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> saveCampaigns(List<Campaign> campaigns) async {
    return campaigns.forEach((update) {
      return campaignCollection
          .doc(update.id)
          .update(update.toEntity().toDocument());
    });
  }
}
