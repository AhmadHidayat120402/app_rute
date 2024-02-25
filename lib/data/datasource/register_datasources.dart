import 'package:app_rute/common/global_variable.dart';
import 'package:app_rute/data/models/request/register_request_model.dart';
import 'package:app_rute/data/models/response/register_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class RegisterDataSource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
        Uri.parse("${GlobalVariables.baseUrl}/register"),
        body: model.toJson(),
        headers: {
          "Content-Type": "application/json",
        });
    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return const Left("Terjadi Kesalahan");
    }
  }
}
