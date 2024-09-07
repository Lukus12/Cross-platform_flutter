import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kross/app/extensions/widget_extensions.dart';
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/inside_the_house_screen');
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
              'https://i.ytimg.com/vi/sSkUqDVJjEU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CIAC0AWKAgwIABABGHIgTigxMA8=&amp;rs=AOn4CLCTNMeT5xkOuMvblf9zWDqXME_mhg',
              fit: BoxFit.cover,
            ),
          ),
          20.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ph,
                Text(
                  'Title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                5.ph,
                Text(
                  'Description',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                /*10.ph,
                ElevatedButton(onPressed:(){
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