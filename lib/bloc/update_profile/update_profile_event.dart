part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileEvent with _$UpdateProfileEvent {
  const factory UpdateProfileEvent.started() = _Started;
  const factory UpdateProfileEvent.updateProfile(
      ProfileRequestModel model, String id) = _UpdateProfile;
}
