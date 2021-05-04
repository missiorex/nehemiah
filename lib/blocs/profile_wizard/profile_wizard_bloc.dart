import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:user_repository/user_repository.dart';

part 'profile_wizard_event.dart';
part 'profile_wizard_state.dart';

class ProfileWizardBloc extends Bloc<ProfileWizardEvent, ProfileWizardState> {
  ProfileWizardBloc() : super(ProfileWizardState.initial());

  @override
  Stream<ProfileWizardState> mapEventToState(
    ProfileWizardEvent event,
  ) async* {
    if (event is ProfileWizardNameSubmitted) {
      yield state.copyWith(
        profile: state.profile.copyWith(name: event.name),
      );
    } else if (event is ProfileWizardDisplayNameSubmitted) {
      yield state.copyWith(
        profile: state.profile.copyWith(displayName: event.displayName),
      );
    } else if (event is GetPhoto) {
      final photo = event.photo;
      yield PhotoSetState(
          photo, state.profile.copyWith(photoUrl: event.photoUrl));
    } else if (event is PhotoUploaded) {
      yield PhotoUploadedState(
          event.photo, state.profile.copyWith(photoUrl: event.photoUrl));
    }
  }
}

//
//ProfileWizardDisplayNameSubmitted
//
//ProfileWizardGenderSubmitted
//
//ProfileWizardPhotoUrlSubmitted
//
//ProfileWizardBirthdaySubmitted
