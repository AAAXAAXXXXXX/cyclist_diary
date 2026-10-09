import 'package:flutter/material.dart';

import '../../core/widgets/diary_widgets.dart';

enum AuthPage { login, register, recovery }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onLogin});
  final VoidCallback onLogin;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthPage page = AuthPage.login;
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeat = TextEditingController();
  bool sent = false;
  String get title => switch (page) {
    AuthPage.login => 'Вхід',
    AuthPage.register => 'Реєстрація',
    AuthPage.recovery => 'Відновлення пароля',
  };
  void navigate(AuthPage next) => setState(() {
    page = next;
    sent = false;
    password.clear();
    repeat.clear();
  });
  @override
  void dispose() {
    for (final c in [name, email, password, repeat]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        const SizedBox(height: 32),
        if (page == AuthPage.register)
          DiaryField(label: 'Ім’я', controller: name),
        DiaryField(label: 'Електронна пошта', controller: email, email: true),
        if (page != AuthPage.recovery)
          DiaryField(label: 'Пароль', controller: password, password: true),
        if (page == AuthPage.register)
          DiaryField(
            label: 'Повторіть пароль',
            controller: repeat,
            password: true,
          ),
        if (page == AuthPage.login) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => navigate(AuthPage.recovery),
              child: const Text('Забули пароль?'),
            ),
          ),
          DiaryButton(label: 'Увійти', onPressed: widget.onLogin),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => navigate(AuthPage.register),
            child: const Text('Зареєструватися'),
          ),
        ],
        if (page == AuthPage.register)
          DiaryButton(label: 'Зареєструватися', onPressed: widget.onLogin),
        if (page == AuthPage.recovery) ...[
          DiaryButton(
            label: 'Надіслати інструкції',
            onPressed: () => setState(() => sent = true),
          ),
          if (sent) ...[
            const SizedBox(height: 20),
            const DiaryCard(
              child: Text(
                'Якщо обліковий запис із такою поштою існує, інструкцію для відновлення пароля надіслано.',
              ),
            ),
          ],
        ],
        if (page != AuthPage.login)
          TextButton(
            onPressed: () => navigate(AuthPage.login),
            child: const Text('Повернутися до входу'),
          ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: constraints.maxWidth >= 850
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Щоденник\nвелосипедиста',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    const SizedBox(height: 32),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/images/trip.png',
                                        height: 280,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Поїздки, які хочеться пам’ятати',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 64),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: form,
                              ),
                            ),
                          ],
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: form,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
