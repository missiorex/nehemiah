import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Child {
  final String id;
  final String name;
  final String displayName;
  final String gender;
  final String password;
  final bool status;
  final String photoUrl;
  final DateTime userAddedOn;
  final DateTime lastAccessedOn;
  final DateTime birthday;

  const Child({
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
  });

  Child copyWith({
    String id,
    String name,
    String displayName,
    String gender,
    String password,
    bool status,
    String photoUrl,
    int userAddedOn,
    int lastAccessedOn,
    int birthday,
  }) {
    return Child(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
      userAddedOn: userAddedOn ?? this.userAddedOn,
      lastAccessedOn: lastAccessedOn ?? this.lastAccessedOn,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      displayName.hashCode ^
      gender.hashCode ^
      password.hashCode ^
      status.hashCode ^
      photoUrl.hashCode ^
      userAddedOn.hashCode ^
      lastAccessedOn.hashCode ^
      birthday.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Child &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          displayName == other.displayName &&
          gender == other.gender &&
          password == other.password &&
          status == other.status &&
          photoUrl == other.photoUrl &&
          userAddedOn == other.userAddedOn &&
          lastAccessedOn == other.lastAccessedOn &&
          birthday == other.birthday;

  @override
  String toString() {
    return 'User: ("Name": ${this.name}, "display name": ${this.displayName}, "birthday": ${this.birthday}, '
        '"user added on": ${this.userAddedOn},"Last Accessed On": ${this.lastAccessedOn}, "password":${this.password},"status":${this.status},});';
  }

  ChildEntity toEntity() {
    return ChildEntity(
        id,
        name,
        displayName,
        gender,
        password,
        status,
        photoUrl,
        userAddedOn.millisecondsSinceEpoch,
        lastAccessedOn.millisecondsSinceEpoch,
        birthday.millisecondsSinceEpoch);
  }

  static Child fromEntity(ChildEntity entity) {
    return Child(
      id: entity.id,
      name: entity.name,
      displayName: entity.displayName,
      gender: entity.gender,
      password: entity.password,
      status: entity.status,
      photoUrl: entity.photoUrl,
      userAddedOn: DateTime.fromMillisecondsSinceEpoch(entity.userAddedOn),
      lastAccessedOn:
          DateTime.fromMillisecondsSinceEpoch(entity.lastAccessedOn),
      birthday: DateTime.fromMillisecondsSinceEpoch(entity.birthday),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'gender': gender,
      'password': password,
      'status': status ? 1 : 0,
      'photoUrl': photoUrl,
      'userAddedOn': userAddedOn,
      'lastAccessedOn': lastAccessedOn,
      'birthday': birthday,
    };
  }

  /// Empty child which represents an unselected user.
  static const empty = Child(id: '', name: '', photoUrl: '');
}
