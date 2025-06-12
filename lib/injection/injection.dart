import 'package:dio/dio.dart';
import 'package:recipes_app/rest_client/rest_client.dart';

final dio= Dio(
  BaseOptions(
 headers: {"Content-Type": "application/json", "Accept": "application/json"},
  ),
);

final restClient= RestClient(Dio());