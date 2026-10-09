import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cyclist_diary/main.dart';

void main() {
  testWidgets('Login, profile, password navigation and logout', (tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();
    expect(find.text('Остання поїздка'), findsOneWidget);
    await tester.tap(find.text('Мій профіль'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    await tester.tap(find.text('Змінити пароль'));
    await tester.pumpAndSettle();
    expect(find.text('Поточний пароль'), findsOneWidget);
    await tester.tap(find.text('Скасувати'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Вийти з облікового запису'));
    await tester.pumpAndSettle();
    expect(find.text('Увійти'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Recovery and registration on a narrow screen', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Забули пароль?'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Надіслати інструкції'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Якщо обліковий запис'), findsOneWidget);
    await tester.tap(find.text('Повернутися до входу'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Зареєструватися'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNWidgets(4));
    expect(tester.takeException(), isNull);
  });
}
