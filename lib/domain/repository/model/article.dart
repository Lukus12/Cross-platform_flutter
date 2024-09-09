import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';
@JsonSerializable()
class Article {
  Article({
    required this.date,
    required this.explanation,
    required this.title,
    required this.imageUrl,
  });
  final String date;
  final String explanation;
  final String title;
  final String? imageUrl;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}