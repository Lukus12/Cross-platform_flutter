import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InsideTheHouse extends StatelessWidget {
  const InsideTheHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _InsideTheHouse(),
    );
  }
}

class _InsideTheHouse extends StatelessWidget {
  const _InsideTheHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: const Text(
          'The Details',
          style: TextStyle(fontWeight: FontWeight.bold), // Жирный текст заголовка
        ),
        centerTitle: true,
        elevation: 4, // Тень под AppBar
      ),
      body: SingleChildScrollView( // Сделаем тело прокручиваемым
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Скругленные углы для изображения
              child: Image.network(
                'https://i.ytimg.com/vi/sSkUqDVJjEU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CIAC0AWKAgwIABABGHIgTigxMA8=&amp;rs=AOn4CLCTNMeT5xkOuMvblf9zWDqXME_mhg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Title',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold), // Жирный заголовок
              ),
            ),

            // Описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Description. Add more details here that will explain the context and relevance of the image and title above.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5), // Более высокий межстрочный интервал
              ),
            ),
            const SizedBox(height: 20), // Отступ перед кнопкой

            Center( // Центрируем кнопку
              child: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[900],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Объемные отступы
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Скругленные углы для кнопки
                  ),
                ),
                child: const Text(
                  'Назад',
                  style: TextStyle(color:Colors.black,fontSize: 16, fontWeight: FontWeight.bold), // Увеличенный размер текста кнопки
                ),
              ),
            ),
            const SizedBox(height: 20), // Дополнительный отступ внизу
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(InsideTheHouse());
}
