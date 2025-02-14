import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kross/data/data.dart';
import 'package:kross/domain/domain.dart';

class FavoritesRepository extends FavoritesRepositoryInterface {
  FavoritesRepository({required this.dio});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Dio dio;

  @override
  Future<List<String>> getFavoriteDates() async {
    print('[FavoritesRepository] Getting favorite dates...');
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('[FavoritesRepository] User not authenticated!');
      throw Exception('Пользователь не авторизован');
    }

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final dates = List<String>.from(doc.data()?['favorites'] ?? []);
      print('[FavoritesRepository] Retrieved ${dates.length} dates');
      return dates;
    } catch (e) {
      print('[FavoritesRepository] Error getting dates: $e');
      throw e;
    }
  }

  Future<void> toggleFavorite(String date) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Пользователь не авторизован');

    final ref = _firestore.collection('users').doc(user.uid);
    final favorites = await getFavoriteDates();

    if (favorites.contains(date)) {
      await ref.update({
        'favorites': FieldValue.arrayRemove([date])
      });
    } else {
      await ref.update({
        'favorites': FieldValue.arrayUnion([date])
      });
    }
  }

  @override
  Future<List<Article>> getFavoriteArticles(List<String> dates) async {
    print('[FavoritesRepository] Получение ${dates.length} articles');
    try {
      final articles = <Article>[];
      for (final date in dates) {
        print('[FavoritesRepository] Найдены даты: $date');
        final Response response = await dio.get(
          'https://api.nasa.gov/planetary/apod?api_key=WrpLGddbOXMfsuW3fY3VefcfxVgsqZXgjOKbor1J&date=$date&thumbs=1',
        );

        // Логирование полного ответа
        print('[FavoritesRepository] Ответ: ${response.data}');

        // Проверка формата данных
        if (response.data is! Map<String, dynamic>) {
          print('[FavoritesRepository] Неверный формат данных: ${response.data}');
          throw 'Некорректный формат данных';
        }

        articles.add(Article.fromJson(response.data as Map<String, dynamic>));
      }
      print('[FavoritesRepository] Успешно загружено ${articles.length} articles');
      return articles;
    } on DioException catch (e) {
      print('[FavoritesRepository] Dio error: ${e.message}');
      throw e.message.toString();
    } catch (e) {
      print('[FavoritesRepository] Unexpected error: $e');
      throw 'Ошибка загрузки данных';
    }
  }


}