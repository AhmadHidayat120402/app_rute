import 'package:app_rute/common/global_variable.dart';
import 'package:app_rute/data/models/request/login_request_model.dart';
import 'package:app_rute/data/models/response/login_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginDataSources {
  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/login'),
        body: model.toJson(),
        headers: {
          "Content-Type": "application/json",
        });
    if (response.statusCode == 201) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return const Left("Terjadi Kesalahan");
    }
  }
}
