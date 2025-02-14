import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../inside_the_home/bloc/inside_the_home_bloc.dart';
import 'bloc/favorites_bloc.dart';

class FavoritesScreen extends StatefulWidget{
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}


class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: Colors.pink[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<FavoritesBloc, FavoritesState>(
              listener: (context, state) {
                if (state is FavoritesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                print('Текущее состояние (избранное): $state');
                if (state is FavoritesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FavoritesLoaded) {
                  return ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.date),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => context.read<FavoritesBloc>().add(
                            ToggleFavorite(article.date),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          // Кнопка "Назад"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                context.go('/home');
                final insideHomeBloc = context.read<
                    InsideTheHomeBloc>();
                insideHomeBloc.emit(InsideHomeInitial());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[900],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Назад',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}