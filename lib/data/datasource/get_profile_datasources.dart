// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_rute/common/global_variable.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/data/models/response/profile_response_model.dart';

class GetProfileDataSources {
  final LocalDataSource localDataSource;

  GetProfileDataSources(this.localDataSource);
  Future<Either<String, ProfileResponseModel>> getProfile() async {
    try {
      final String token = await localDataSource.getToken();
      final response = await http
          .get(Uri.parse('${GlobalVariables.baseUrl}/profile'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return Right(ProfileResponseModel.fromJson(response.body));
      } else {
        return const Left("Terjadi Kesalahan Dalam Pengambilan Data");
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
