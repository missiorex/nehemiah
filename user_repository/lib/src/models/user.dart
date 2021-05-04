import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class User {
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
  final DateTime userAddedOn;
  final DateTime birthday;

  User({
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
  });

  User copyWith({
    String id,
    String name,
    String displayName,
    String emailId,
    String gender,
    String country,
    String password,
    String phoneNumber,
    bool status,
    bool isAdmin,
    String photoUrl,
    int userAddedOn,
    int birthday,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      emailId: emailId ?? this.emailId,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
      photoUrl: photoUrl ?? this.photoUrl,
      userAddedOn: userAddedOn ?? this.userAddedOn,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      displayName.hashCode ^
      emailId.hashCode ^
      gender.hashCode ^
      country.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      status.hashCode ^
      isAdmin.hashCode ^
      photoUrl.hashCode ^
      userAddedOn.hashCode ^
      birthday.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          displayName == other.displayName &&
          emailId == other.emailId &&
          gender == other.gender &&
          country == other.country &&
          password == other.password &&
          phoneNumber == other.phoneNumber &&
          status == other.status &&
          isAdmin == other.isAdmin &&
          photoUrl == other.photoUrl &&
          userAddedOn == other.userAddedOn &&
          birthday == other.birthday;

  @override
  String toString() {
    return 'User: ("Name": ${this.name}, "display name": ${this.displayName}, "birthday": ${this.birthday}, '
        '"user added on": ${this.userAddedOn}, "password":${this.password},"status":${this.status},});';
  }

  UserEntity toEntity() {
    return UserEntity(
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
        userAddedOn.millisecondsSinceEpoch,
        birthday.millisecondsSinceEpoch);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      name: entity.name,
      displayName: entity.displayName,
      emailId: entity.emailId,
      gender: entity.gender,
      country: entity.country,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      isAdmin: entity.isAdmin,
      photoUrl: entity.photoUrl,
      userAddedOn: DateTime.fromMillisecondsSinceEpoch(entity.userAddedOn),
      birthday: DateTime.fromMillisecondsSinceEpoch(entity.birthday),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'emailId': emailId,
      'gender': gender,
      'country': country,
      'password': password,
      'phoneNumber': phoneNumber,
      'status': status ? 1 : 0,
      'isAdmin': isAdmin,
      'photoUrl': photoUrl,
      'userAddedOn': userAddedOn,
      'birthday': birthday,
    };
  }
}
