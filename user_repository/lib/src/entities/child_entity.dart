// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class ChildEntity extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String gender;
  final String password;
  final bool status;
  final String photoUrl;
  final int userAddedOn;
  final int lastAccessedOn;
  final int birthday;

  const ChildEntity(
    this.id,
    this.name,
    this.displayName,
    this.gender,
    this.password,
    this.status,
    this.photoUrl,
    this.userAddedOn,
    this.lastAccessedOn,
    this.birthday,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "displayName": displayName,
      "gender": gender,
      "password": password,
      "status": status,
      "photoUrl": photoUrl,
      "userAddedOn": jsonEncode(userAddedOn, toEncodable: obEncode),
      "lastAccessedOn": jsonEncode(lastAccessedOn, toEncodable: obEncode),
      "birthday": jsonEncode(birthday, toEncodable: obEncode),
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        displayName,
        gender,
        password,
        status,
        photoUrl,
        userAddedOn,
        lastAccessedOn,
        birthday,
      ];

  @override
  String toString() {
    return 'User: ("Name": ${this.name}, "display name": ${this.displayName}, "birthday": ${this.birthday}, '
        '"user added on": ${this.userAddedOn},"last accessedd on": ${this.lastAccessedOn}, "password":${this.password},"status":${this.status},});';
  }

  static ChildEntity fromJson(Map<String, Object> json) {
    return ChildEntity(
        json["id"] as String,
        json["name"] as String,
        json["displayName"] as String,
        json["gender"] as String,
        json["password"] as String,
        json["status"] as bool,
        json["photoUrl"] as String,
        int.parse(json["userAddedOn"]),
        int.parse(json["lastAccessedOn"]),
        int.parse(json["birthday"]));
  }

  static ChildEntity fromSnapshot(DocumentSnapshot snap) {
    return ChildEntity(
      snap.id,
      snap.data()['name'],
      snap.data()['displayName'],
      snap.data()['gender'],
      snap.data()['password'],
      snap.data()['status'] == 1 ? true : false,
      snap.data()['photoUrl'],
      snap.data()['userAddedOn'],
      snap.data()['lastAccessedOn'],
      snap.data()['birthday'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "displayName": displayName,
      "gender": gender,
      "password": password,
      "status": status,
      "description": photoUrl,
      "userAddedOn": userAddedOn,
      "lastAccessedOn": lastAccessedOn,
      "birthday": birthday,
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
