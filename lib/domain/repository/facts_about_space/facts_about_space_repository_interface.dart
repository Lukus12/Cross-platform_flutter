import 'dart:async';
import 'package:kross/domain/domain.dart';
import 'package:kross/domain/repository/model/article.dart';
abstract class FactsAboutSpaceRepositoryIterface {
  Future<List<Article>> getFactsAboutSpace();
}
