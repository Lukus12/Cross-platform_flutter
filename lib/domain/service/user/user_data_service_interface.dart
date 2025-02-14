import 'package:kross/domain/service/user/user_data.dart';

abstract class UserDataServiceInterface{
  /// Получает данные пользователя из Firestore.
  Future<UserData> getUserData();

  /// Добавляет данные нового пользователя в Firestore.
  Future<void> addUserData({
    required String name,
    required String email,
  });

  /// Обновляет данные существующего пользователя в Firestore.
  Future<void> updateUserData({
    required String name,
    required String description,
  });

  /// Удаляет данные пользователя из Firestore.
  Future<void> deleteUserData();

  //работа со страничкой
  Future<void> addToFavorites(String articleId);
  Future<void> removeFromFavorites(String articleId);
  Future<List<String>> getFavorites();
}