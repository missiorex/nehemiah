part of 'profile_wizard_bloc.dart';

//class Child extends Equatable {
//  const Child(
//      {@required this.name,
//      @required this.displayName,
//      @required this.gender,
//      @required this.photoUrl,
//      @required this.birthday});
//
//  final String name;
//  final String displayName;
//  final String gender;
//  final String photoUrl;
//  final DateTime birthday;
//
//  Child copyWith(
//      {String name,
//      String displayName,
//      String gender,
//      String photoUrl,
//      DateTime birthday}) {
//    return Child(
//      name: name ?? this.name,
//      displayName: displayName ?? this.displayName,
//      gender: gender ?? this.gender,
//      photoUrl: photoUrl ?? this.photoUrl,
//      birthday: birthday ?? this.birthday,
//    );
//  }
//
//  @override
//  List<Object> get props => [name, displayName, gender, photoUrl, birthday];
//}

class ProfileWizardState extends Equatable {
  ProfileWizardState({@required this.profile, @required this.photo})
      : lastUpdated = DateTime.now();

  ProfileWizardState.initial()
      : this(
            profile: Child(
                name: null,
                displayName: null,
                gender: null,
                photoUrl: null,
                birthday: null),
            photo: File(""));

  final Child profile;
  final DateTime lastUpdated;
  final File photo;

  ProfileWizardState copyWith({Child profile}) {
    return ProfileWizardState(
        profile: profile ?? this.profile, photo: File(""));
  }

  @override
  List<Object> get props => [profile, lastUpdated];
}

class PhotoInitialState extends ProfileWizardState {
  final File photo;
  final Child profile;

  PhotoInitialState(this.photo, this.profile)
      : super(profile: profile, photo: photo);
  @override
  List<Object> get props => this.props;
}

class PhotoSetState extends ProfileWizardState {
  final File photo;
  final Child profile;

  PhotoSetState(this.photo, this.profile)
      : super(profile: profile, photo: photo);

  @override
  List<Object> get props => [photo, profile];
}

class PhotoUploadedState extends ProfileWizardState {
  final File photo;
  final Child profile;

  PhotoUploadedState(this.photo, this.profile)
      : super(profile: profile, photo: photo);

  @override
  List<Object> get props => [photo, profile];
}
