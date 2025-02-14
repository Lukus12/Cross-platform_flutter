import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kross/app/features/features.dart';

import '../../../domain/repository/model/article.dart';
import '../favorites/bloc/favorites_bloc.dart';

class InsideTheHomeScreen extends StatefulWidget {
  const InsideTheHomeScreen({super.key});

  @override
  State<InsideTheHomeScreen> createState() => InsideTheHomeScreenState();
}

class InsideTheHomeScreenState extends State<InsideTheHomeScreen> {
  late Article _articleFav;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesBloc>().add(LoadFavorites());
      final insideHomeBloc = context.read<InsideTheHomeBloc>();
      if (insideHomeBloc.state is InsideHomeInitial) {
        insideHomeBloc.add(const InsideHomeLoad());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<InsideTheHomeBloc>().state;

    if (state is InsideHomeLoadInProgress) {
      return Center(child: CircularProgressIndicator());
    } else if (state is InsideHomeLoadFailure) {
      return Center(child: Text('Error: ${state.exception}'));
    } else if (state is InsideHomeLoadSuccess) {
      final article = state.article;

      return BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state is FavoritesLoaded &&
                state.articles.any((a) => a.date == article.date);

            return Scaffold(
              backgroundColor: Colors.green[200],
              appBar: AppBar(
                backgroundColor: Colors.pink[900],
                title: const Text('Подробнее'),
                actions: [
                  IconButton(
                    icon: Icon(isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border
                    ),
                    onPressed: () => context.read<FavoritesBloc>().add(
                        ToggleFavorite(article.date)
                    ),
                  ),
                ],
                centerTitle: true,
                elevation: 4,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      child: Image.network(
                        article.imageUrl ?? '',
                        fit: BoxFit.scaleDown,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        article.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        article.explanation,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/home');

                          final insideHomeBloc = context.read<
                              InsideTheHomeBloc>();
                          insideHomeBloc.emit(InsideHomeInitial());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[900],
                          padding: const EdgeInsets.symmetric(horizontal: 20,
                              vertical: 12),
                        ),
                        child: const Text(
                          'Назад',
                          style: TextStyle(color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
      );
    }
    return Container();
  }
}

