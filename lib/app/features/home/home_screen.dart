import 'package:flutter/material.dart';
import 'package:kross/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/app/features/home/bloc/home_bloc.dart';
import 'package:kross/di/di.dart';
import 'package:kross/domain/domain.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные, только если еще не загружены
    final homeBloc = context.read<HomeBloc>();
    if (homeBloc.state is HomeInitial) {
      homeBloc.add(const HomeLoad());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          title: const Text('Главная'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                final homeBloc = context.read<HomeBloc>();
                homeBloc.emit(HomeInitial()); // Сбрасываем состояние блока в HomeInitial
                homeBloc.add(const HomeLoad()); // Загружаем данные заново
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>( // Строим тело с помощью BlocBuilder
          builder: (context, state) { // Получаем текущее состояние блока
            print('Текущее состояние: $state');
            if (state is HomeLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadSuccess) {
              List<Article> articles = state.articles; // Получаем список статей
              return SingleChildScrollView( // Используем прокручиваемый виджет
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Факты о космосе', style: Theme.of(context).textTheme.headlineLarge),
                    SizedBox(height: 20),
                    ListView.separated(
                      primary: false, // Отключаем прокрутку в родительском элементе
                      shrinkWrap: true, // Обеспечиваем корректный размер списка
                      itemCount: articles.length,
                      itemBuilder: (context, index) { // Строим элементы списка
                        return ArticleCard(
                          title: articles[index].title,
                          explanation: articles[index].explanation,
                          imageUrl: articles[index].imageUrl,
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
                    ),
                  ],
                ),
              );
            }
            if (state is HomeLoadFailure) { // Проверяем, произошла ли ошибка при загрузке
              return ErrorCard(
                title: 'Ошибка',
                description: state.exception.toString(),
                onReload: () {
                  context.read<HomeBloc>().add(const HomeLoad());
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final VoidCallback onReload;

  const ErrorCard({
    Key? key,
    required this.title,
    required this.description,
    this.icon,
    required this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: Colors.red, size: 40),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}