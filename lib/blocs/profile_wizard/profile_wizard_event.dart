part of 'profile_wizard_bloc.dart';

abstract class ProfileWizardEvent extends Equatable {
  const ProfileWizardEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ProfileWizardNameSubmitted extends ProfileWizardEvent {
  const ProfileWizardNameSubmitted(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ProfileWizardDisplayNameSubmitted extends ProfileWizardEvent {
  const ProfileWizardDisplayNameSubmitted(this.displayName);

  final String displayName;

  @override
  List<Object> get props => [displayName];
}

class ProfileWizardGenderSubmitted extends ProfileWizardEvent {
  const ProfileWizardGenderSubmitted(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class ProfileWizardPhotoUrlSubmitted extends ProfileWizardEvent {
  const ProfileWizardPhotoUrlSubmitted(this.photoUrl);

  final String photoUrl;

  @override
  List<Object> get props => [photoUrl];
}

class ProfileWizardBirthdaySubmitted extends ProfileWizardEvent {
  const ProfileWizardBirthdaySubmitted(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

class GetPhoto extends ProfileWizardEvent {
  final File photo;
  final String photoUrl;

  GetPhoto(this.photo, this.photoUrl) : super();

  @override
  List<Object> get props => [];
}

class PhotoUploaded extends ProfileWizardEvent {
  final File photo;
  final String photoUrl;

  PhotoUploaded(this.photo, this.photoUrl) : super();

  @override
  List<Object> get props => [photo, photoUrl];
}
