// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'entities/entities.dart';

class FirebaseCampaignRepository implements CampaignRepository {
  final campaignCollection = FirebaseFirestore.instance.collection('campaigns');
  final statsRef =
      FirebaseFirestore.instance.collection('stats').doc('--campaigns--');

  final priorityCampaignsCollection = FirebaseFirestore.instance
      .collection('campaigns')
      .where('isPriority', isEqualTo: true);

  @override
  Future<void> addNewCampaign(Campaign campaign) {
    var batch = FirebaseFirestore.instance.batch();
    batch.set(
        campaignCollection.doc(campaign.id), campaign.toEntity().toDocument());
    batch.set(statsRef, {'campaignsCount': FieldValue.increment(1)},
        SetOptions(merge: true));
    return batch.commit();
  }

  @override
  Future<void> deleteCampaign(Campaign campaign) async {
    var batch = FirebaseFirestore.instance.batch();
    batch.delete(campaignCollection.doc(campaign.id));
    batch.set(statsRef, {'campaignsCount': FieldValue.increment(-1)},
        SetOptions(merge: true));
    return batch.commit();
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

  @override
  Future<void> incrementRosaryCount(Campaign campaign) async {
    final DocumentReference ref = campaignCollection.doc(campaign.id);

    // Update rosary  count
    ref.update({'rosaryCount': FieldValue.increment(1)});

//    await ref.update(<String, dynamic>{
//      'rosaryCount': FieldValue.increment(1),
//    });
  }
}
