part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;
  const factory UpdateProfileState.loading() = _Loading;
  const factory UpdateProfileState.loaded(ProfileResponseModel model) = _Loaded;
  const factory UpdateProfileState.error(String message) = _Error;
}
