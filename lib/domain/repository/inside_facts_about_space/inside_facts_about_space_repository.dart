import 'dart:async';
import 'package:dio/dio.dart';
import 'package:kross/data/data.dart';
import 'package:kross/domain/domain.dart';

class InsideFactsAboutSpaceRepository extends InsideFactsAboutSpaceRepositoryInterface {
  InsideFactsAboutSpaceRepository({required this.dio});
  final Dio dio;
  @override
  @override
  Future<Article> getFactsAboutSpace() async {
    try {
      final Response response = await dio.get(
        Endpoints.tagApod,
        queryParameters: {
          'count':'1',
          'thumbs':'1',
        },
      );

      // Assuming the response always returns a list with one element
      return Article.fromJson((response.data as List)
          .first
      );
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
