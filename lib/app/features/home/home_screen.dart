import 'package:flutter/material.dart';
import 'package:kross/app/extensions/widget_extensions.dart';
import 'package:kross/app/widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          title: const Text(
            'Home',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Header',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              20.ph,
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Отступы для карточки
                    decoration: BoxDecoration(
                      color: Colors.green[400], // Фоновый цвет
                      borderRadius: BorderRadius.circular(10.0), // Округленные углы
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Тень
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Смещение тени
                        ),
                      ],
                    ),
                    child: const ArticleCard(),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 20,
                    thickness: 1, // Толщина разделителя
                    color: Colors.grey.withOpacity(0.5),
                    indent: 16, // Отступ слева
                    endIndent: 16, // Отступ справа
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}