// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CampaignEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool complete;
  final int rosaryCount;
  final int mercyChapletCount;
  final double fastingHourCount;
  final int penanceCount;
  final String imageUrl;
  final String lsImageUrl;
  final String category;
  final String language;
  final bool isActive;
  final bool isPriority;
  final int createdTime;
  final int publishTime;

  const CampaignEntity(
    this.id,
    this.title,
    this.description,
    this.complete,
    this.rosaryCount,
    this.mercyChapletCount,
    this.fastingHourCount,
    this.penanceCount,
    this.imageUrl,
    this.lsImageUrl,
    this.category,
    this.language,
    this.isActive,
    this.isPriority,
    this.createdTime,
    this.publishTime,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "complete": complete,
      "rosaryCount": rosaryCount,
      "mercyChapletCount": mercyChapletCount,
      "fastingHourCount": fastingHourCount,
      "penanceCount": penanceCount,
      "imageUrl": imageUrl,
      "lsImageUrl": lsImageUrl,
      "category": category,
      "language": language,
      "isActive": isActive,
      "isPriority": isPriority,
      "createdTime": jsonEncode(createdTime, toEncodable: obEncode),
      "publishTime": jsonEncode(publishTime, toEncodable: obEncode),
    };
  }

  @override
  List<Object> get props => [
        complete,
        id,
        title,
        description,
        rosaryCount,
        mercyChapletCount,
        fastingHourCount,
        penanceCount,
        imageUrl,
        lsImageUrl,
        category,
        language,
        isActive,
        isPriority,
        createdTime,
        publishTime,
      ];

  @override
  String toString() {
    return 'Campaign { complete: $complete, title: $title, description: $description, id: $id }';
  }

  static CampaignEntity fromJson(Map<String, Object> json) {
    return CampaignEntity(
      json["id"] as String,
      json["title"] as String,
      json["description"] as String,
      json["complete"] as bool,
      json["rosaryCount"] as int,
      json["mercyChapletCount"] as int,
      json["fastingHourCount"] as double,
      json["penanceCount"] as int,
      json["imageUrl"] as String,
      json["lsImageUrl"] as String,
      json["category"] as String,
      json["language"] as String,
      json["isActive"] as bool,
      json["isPriority"] as bool,
      json["createdTime"] as int,
      json["publishTime"] as int,
    );
  }

  static CampaignEntity fromSnapshot(DocumentSnapshot snap) {
    return CampaignEntity(
      snap.id,
      snap.data()['title'],
      snap.data()['description'],
      snap.data()['complete'],
      snap.data()['rosaryCount'],
      snap.data()['mercyChapletCount'],
      snap.data()['fastingHourCount'] as double,
      snap.data()['penanceCount'],
      snap.data()['imageUrl'],
      snap.data()['lsImageUrl'],
      snap.data()['category'],
      snap.data()['language'],
      snap.data()['isActive'] == 1 ? true : false,
      snap.data()['isPriority'] == 1 ? true : false,
      snap.data()['createdTime'],
      snap.data()['publishTime'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "complete": complete,
      "rosaryCount": rosaryCount,
      "mercyChapletCount": mercyChapletCount,
      "fastingHourCount": fastingHourCount,
      "penanceCount": penanceCount,
      "imageUrl": imageUrl,
      "lsImageUrl": lsImageUrl,
      "category": category,
      "language": language,
      "isActive": isActive,
      "isPriority": isPriority,
      "createdTime": createdTime,
      "publishTime": publishTime,
    };
  }

  dynamic obEncode(dynamic item) {
    if (item is DateTime) {
      return item.millisecondsSinceEpoch.toInt();
    } else {
      return item.toString();
    }
  }
}
