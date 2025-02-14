import 'package:kross/domain/domain.dart';
import 'package:kross/domain/repository/model/article.dart';

abstract class FavoritesRepositoryInterface{
  Future<List<Article>> getFavoriteArticles(List<String> dates);
  Future<void> toggleFavorite(String date);
  Future<List<String>> getFavoriteDates();
}