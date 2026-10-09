import 'package:flutter/material.dart';

import '../../core/widgets/diary_widgets.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onLogout});
  final VoidCallback onLogout;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  static const String name = 'Олександр';
  static const labels = [
    'Огляд',
    'Велосипеди',
    'Поїздки',
    'Обслуговування',
    'Мій профіль',
  ];
  static const icons = [
    Icons.dashboard_outlined,
    Icons.pedal_bike,
    Icons.route_outlined,
    Icons.build_outlined,
    Icons.person_outline,
  ];
  Widget navigation(bool drawer) => SafeArea(
    child: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Щоденник\nвелосипедиста',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(icons[i]),
              title: Text(labels[i]),
              selected: selected == i,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                if (i == 0 || i == 4) {
                  setState(() => selected = i);
                }
                if (drawer) Navigator.pop(context);
              },
            ),
          ),
      ],
    ),
  );
  Widget overview() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Огляд', style: Theme.of(context).textTheme.headlineLarge),
      const SizedBox(height: 8),
      Text('Вітаємо, $name! Твій велосипедний щоденник'),
      const SizedBox(height: 28),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          for (final item in [
            ('Загальна відстань', '248,6 км'),
            ('Поїздки', '12'),
            ('Велосипеди', '2'),
          ])
            SizedBox(
              width: 220,
              child: DiaryCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.$1),
                    const SizedBox(height: 12),
                    Text(
                      item.$2,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 32),
      Text('Остання поїздка', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/trip.png',
          width: double.infinity,
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Ранок біля озера',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      const Text('20 вересня 2026 · 32,4 км · 2 год 15 хв'),
      const SizedBox(height: 12),
      const Text('Тихий ліс, прохолодне повітря і зупинка з кавою біля води.'),
      const SizedBox(height: 20),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          DiaryButton(label: 'Переглянути поїздки', onPressed: () {}),
          DiaryButton(
            label: 'Мої велосипеди',
            secondary: true,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: 24),
      const Text('Міський велосипед потребує обслуговування'),
    ],
  );
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 900;
      final content = selected == 0
          ? overview()
          : ProfileScreen(userName: name, onLogout: widget.onLogout);
      return Scaffold(
        appBar: wide
            ? null
            : AppBar(title: const Text('Щоденник велосипедиста')),
        drawer: wide ? null : Drawer(child: navigation(true)),
        body: Row(
          children: [
            if (wide)
              SizedBox(
                width: 250,
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: navigation(false),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(wide ? 36 : 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: content,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
