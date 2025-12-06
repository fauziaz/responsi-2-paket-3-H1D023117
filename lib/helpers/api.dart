import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'user_info.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: data, // ← ini form-urlencoded
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.acceptHeader: "application/json",
        },
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.acceptHeader: "application/json",
        },
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(
          'Server error: ${response.statusCode}',
        );
    }
  }
}