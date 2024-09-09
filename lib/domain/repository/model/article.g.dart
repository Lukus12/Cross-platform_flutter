// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      date: json['date'] as String,
      explanation: json['explanation'] as String,
      title: json['title'] as String,
      imageUrl: json['url'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'date': instance.date,
      'explanation': instance.explanation,
      'title': instance.title,
      'url': instance.imageUrl,
    };
