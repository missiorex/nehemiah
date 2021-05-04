// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class UserEntity {
  String id;
  String displayName;
  String photoUrl;
  String emailId;
  String password;
  String name;
  String country;
  String gender;
  String phoneNumber;
  //List<String> groupMemberOf;
  int userAddedOn;
  int birthday;
  bool status;

  UserEntity(
      {this.id,
      this.displayName,
      this.photoUrl,
      this.emailId,
      this.password,
      this.name,
      this.country,
      this.gender,
      this.phoneNumber,
      //this.groupMemberOf,
      this.userAddedOn,
      this.birthday,
      this.status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl &&
          emailId == other.emailId &&
          password == other.password &&
          name == other.name &&
          country == other.country &&
          gender == other.gender &&
          phoneNumber == other.phoneNumber &&

          //groupMemberOf == other.groupMemberOf &&
          userAddedOn == other.userAddedOn &&
          birthday == other.birthday &&
          status == other.status;

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;

  @override
  String toString() {
    return 'UserEntity{id: $id, displayName: $displayName, photoUrl: $photoUrl}';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'emailId': emailId,
      'password': password,
      'name': name,
      'country': country,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'userAddedOn': userAddedOn,
      'birthday': birthday,
      'status': status,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
        id: json['id'] as String,
        displayName: json['displayName'] as String,
        photoUrl: json['photoUrl'] as String,
        emailId: json['emailId'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        country: json['country'] as String,
        gender: json['gender'] as String,
        phoneNumber: json['phoneNumer'] as String,
        birthday: int.parse(json['birthday'].toString()),
        userAddedOn: int.parse(json['userAddedOn'].toString()),
        status: json['status'] as bool);
  }
}
