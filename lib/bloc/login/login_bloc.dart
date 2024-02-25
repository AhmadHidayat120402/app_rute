// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app_rute/data/datasource/login_datasources.dart';
import 'package:app_rute/data/models/request/login_request_model.dart';
import 'package:app_rute/data/models/response/login_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginDataSources dataSources;
  LoginBloc(
    this.dataSources,
  ) : super(const _Initial()) {
    on<_DoLogin>((event, emit) async {
      emit(const LoginState.loading());
      final result = await dataSources.login(event.model);
      result.fold(
        (l) => emit(LoginState.error(l)),
        (r) => emit(LoginState.loaded(r)),
      );
    });
  }
}
