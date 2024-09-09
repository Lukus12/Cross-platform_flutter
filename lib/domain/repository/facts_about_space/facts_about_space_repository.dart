import 'dart:async';
import 'package:dio/dio.dart';
import 'package:kross/data/data.dart';
import 'package:kross/domain/domain.dart';

class KrossRepository extends KrossRepositoryIterface {
  KrossRepository({required this.dio});
  final Dio dio;
  @override
  Future<List<Article>> getFactsAboutSpace() async {
    try {
      final Response response = await dio.get(
        Endpoints.tagApod,
        queryParameters: {
          'count':'5',
          'thumbs':'1',
        },
      );

      final facts = (response.data as List)
          .map((e) => Article.fromJson(e))
          .toList();
      return facts;

    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
