// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:app_rute/common/global_variable.dart';
import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/data/models/request/profile_request_model.dart';
import 'package:app_rute/data/models/response/profile_response_model.dart';

class UpdateProfileDataSources {
  final LocalDataSource localDataSource;

  UpdateProfileDataSources(
    this.localDataSource,
  );
  Future<Either<String, ProfileResponseModel>> updateProfile(
      ProfileRequestModel model, String id) async {
    try {
      print("id :  $id");
      final String token = await localDataSource.getToken();
      final String id2 = await LocalDataSource.getId();
      print("model : ${model.toJson()}");
      print("token : $token");
      print("id2 :  $id2");
      final response =
          await http.put(Uri.parse('${GlobalVariables.baseUrl}/profile/$id'),
              headers: {
                'Authorization': 'Bearer $token',
                "Content-Type": "application/json",
              },
              body: model.toJson());

      print("result ${response.body}");
      if (response.statusCode == 200) {
        return Right(ProfileResponseModel.fromJson(response.body));
      } else {
        return const Left("Terjadi Kesalahan Perubahan Data");
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
