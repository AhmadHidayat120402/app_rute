// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_rute/data/models/request/register_request_model.dart';
import 'package:app_rute/data/models/response/register_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_rute/data/datasource/register_datasources.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterDataSource dataSource;
  RegisterBloc(
    this.dataSource,
  ) : super(const _Initial()) {
    on<_DoRegister>((event, emit) async {
      emit(const RegisterState.loading());
      final result = await dataSource.register(event.model);
      result.fold(
        (l) => emit(RegisterState.error(l)),
        (r) => emit(RegisterState.loaded(r)),
      );
    });
  }
}
