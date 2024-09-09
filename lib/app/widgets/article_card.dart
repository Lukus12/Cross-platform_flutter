import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kross/app/extensions/widget_extensions.dart';

class ArticleCard extends StatelessWidget {
  final String title; // Заголовок статьи
  final String explanation; // Объяснение статьи
  final String? imageUrl; // URL изображения

  const ArticleCard({
    Key? key,
    required this.title,
    required this.explanation,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/inside_the_home_screen');
      },
      borderRadius: BorderRadius.circular(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              width: 100,
              height: 100,
              imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          20.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.ph,
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                5.ph,
                Text(
                  explanation,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                5.ph,
                /*ElevatedButton(onPressed:(){
                  context.go('/inside_the_house_screen');
                }, child: const Text('Подробнее'))*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}