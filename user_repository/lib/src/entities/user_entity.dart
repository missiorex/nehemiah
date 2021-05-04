// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String emailId;
  final String gender;
  final String country;
  final String password;
  final String phoneNumber;
  final bool status;
  final bool isAdmin;
  final String photoUrl;
  final int userAddedOn;
  final int birthday;

  const UserEntity(
    this.id,
    this.name,
    this.displayName,
    this.emailId,
    this.gender,
    this.country,
    this.password,
    this.phoneNumber,
    this.status,
    this.isAdmin,
    this.photoUrl,
    this.userAddedOn,
    this.birthday,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "displayName": displayName,
      "emailId": emailId,
      "gender": gender,
      "country": country,
      "password": password,
      "language": phoneNumber,
      "status": status,
      "isAdmin": isAdmin,
      "photoUrl": photoUrl,
      "userAddedOn": jsonEncode(userAddedOn, toEncodable: obEncode),
      "birthday": jsonEncode(birthday, toEncodable: obEncode),
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        displayName,
        emailId,
        gender,
        country,
        password,
        phoneNumber,
        status,
        isAdmin,
        photoUrl,
        userAddedOn,
        birthday,
      ];

  @override
  String toString() {
    return 'User: ("Name": ${this.name}, "display name": ${this.displayName}, "birthday": ${this.birthday}, '
        '"user added on": ${this.userAddedOn}, "password":${this.password},"phoneNumber":${this.phoneNumber},"status":${this.status},"isAdmin":${this.isAdmin});';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
        json["id"] as String,
        json["name"] as String,
        json["displayName"] as String,
        json["emailID"] as String,
        json["gender"] as String,
        json["country"] as String,
        json["password"] as String,
        json["phoneNumber"] as String,
        json["status"] as bool,
        json["isAdmin"] as bool,
        json["photoUrl"] as String,
        int.parse(json["userAddedOn"]),
        int.parse(json["birthday"]));
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.id,
      snap.data()['name'],
      snap.data()['displayName'],
      snap.data()['emailID'],
      snap.data()['gender'],
      snap.data()['country'],
      snap.data()['password'],
      snap.data()['phoneNumber'],
      snap.data()['status'] == 1 ? true : false,
      snap.data()['isAdmin'] == 1 ? true : false,
      snap.data()['photoUrl'],
      snap.data()['userAddedOn'],
      snap.data()['birthday'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "displayName": displayName,
      "emailId": emailId,
      "gender": gender,
      "country": country,
      "password": password,
      "phoneNumber": phoneNumber,
      "status": status,
      "isAdmin": isAdmin,
      "description": photoUrl,
      "userAddedOn": userAddedOn,
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
