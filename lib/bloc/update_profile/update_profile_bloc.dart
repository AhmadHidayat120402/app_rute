// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_rute/data/datasource/update_profile_datasources.dart';
import 'package:app_rute/data/models/request/profile_request_model.dart';
import 'package:app_rute/data/models/response/profile_response_model.dart';

part 'update_profile_bloc.freezed.dart';
part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileDataSources _updateProfileDataSources;
  final String id;
  UpdateProfileBloc(
    this._updateProfileDataSources,
    this.id,
  ) : super(const _Initial()) {
    on<_UpdateProfile>((event, emit) async {
      try {
        emit(const UpdateProfileState.loading());
        final result = await _updateProfileDataSources.updateProfile(
            event.model, event.id);
        result.fold(
          (l) => emit(UpdateProfileState.error(l)),
          (r) => emit(UpdateProfileState.loaded(r)),
        );
      } catch (e) {}
    });
  }
}
