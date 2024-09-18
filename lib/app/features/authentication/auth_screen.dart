import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kross/app/features/features.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF201E28),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Вход в аккаунт',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFFDFDFD),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Введите email',
                  hintStyle: const TextStyle(color: Color(0xFF6A6A6A)),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFFDFDFD)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Введите пароль',
                  hintStyle: const TextStyle(color: Color(0xFF6A6A6A)),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                obscureText: true,
                style: const TextStyle(color: Color(0xFFFDFDFD)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  /*context.read<AuthBloc>().add(
                    LogInEvent(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );*/
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[600],
                  minimumSize: const Size(220, 50),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF271F08),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              GestureDetector(
                onTap: () {
                  context.go('/reg');
                },
                child: const Text(
                  'Зарегистрироваться',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFFFDFDFD),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}