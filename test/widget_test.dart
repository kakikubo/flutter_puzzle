// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui';

import 'package:flutter_puzzle/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('スタート画面が表示される', (WidgetTester tester) async {
    // ここにテスト内容を書く
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(const PuzzleApp());

    expect(find.text('スライドパズル'), findsOneWidget);
    expect(find.text('スタート'), findsOneWidget);
  });
}
