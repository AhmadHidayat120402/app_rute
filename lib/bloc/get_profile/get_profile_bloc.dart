// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_rute/data/datasource/get_profile_datasources.dart';
import 'package:app_rute/data/models/response/profile_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_profile_bloc.freezed.dart';
part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final GetProfileDataSources getProfileDataSources;

  GetProfileBloc(
    this.getProfileDataSources,
  ) : super(const _Initial()) {
    on<_GetProfile>((event, emit) async {
      try {
        emit(const GetProfileState.loading());
        final result = await getProfileDataSources.getProfile();
        result.fold(
          (l) => emit(GetProfileState.error(l)),
          (r) => emit(
            GetProfileState.loaded(r),
          ),
        );
      } catch (e) {}
    });
  }
}
