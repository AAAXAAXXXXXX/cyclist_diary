import 'package:flutter/material.dart';

import '../../core/widgets/diary_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.userName,
    required this.onLogout,
  });
  final String userName;
  final VoidCallback onLogout;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final name = TextEditingController(text: widget.userName);
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Мій профіль', style: Theme.of(context).textTheme.headlineLarge),
      const SizedBox(height: 32),
      Wrap(
        spacing: 24,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const CircleAvatar(
            radius: 48,
            child: Text('ОК', style: TextStyle(fontSize: 32)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiaryButton(
                label: 'Додати / замінити фото',
                secondary: true,
                onPressed: () {},
              ),
              TextButton(onPressed: () {}, child: const Text('Видалити фото')),
            ],
          ),
        ],
      ),
      const SizedBox(height: 32),
      DiaryField(label: 'Ім’я', controller: name),
      const SelectableText('Електронна пошта для входу: cyclist@example.com'),
      const SizedBox(height: 28),
      Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          DiaryButton(label: 'Зберегти зміни', onPressed: () {}),
          DiaryButton(
            label: 'Змінити пароль',
            secondary: true,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ChangePasswordScreen(),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Темна тема'),
        value: false,
        onChanged: (_) {},
      ),
      const SizedBox(height: 16),
      TextButton(
        onPressed: widget.onLogout,
        child: const Text('Вийти з облікового запису'),
      ),
    ],
  );
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final current = TextEditingController();
  final next = TextEditingController();
  final repeat = TextEditingController();
  @override
  void dispose() {
    current.dispose();
    next.dispose();
    repeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Зміна пароля')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DiaryField(
                label: 'Поточний пароль',
                controller: current,
                password: true,
              ),
              DiaryField(
                label: 'Новий пароль',
                controller: next,
                password: true,
              ),
              DiaryField(
                label: 'Повторіть новий пароль',
                controller: repeat,
                password: true,
              ),
              DiaryButton(
                label: 'Змінити пароль',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Скасувати'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
