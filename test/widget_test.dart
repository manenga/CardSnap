import 'package:credit_card_capture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our screen title is shown correctly.
    expect(find.text('My Cards'), findsOneWidget);
    expect(find.text('Your Cards'), findsNothing);
    expect(find.text('Scan'), findsNothing);
    expect(find.text('Save Card'), findsNothing);

    // Find the add new card floating action button.
    expect(find.byKey(const Key('add_new_card_fab')), findsOneWidget);
  });
}
//   testWidgets('GIVEN user is on the MyCards Screen'
//       'WHEN the user taps the `+` floating action button'
//       'THEN we navigate the user to the add a new card screen', (tester) async {
//
//     // given
//     await tester.pumpWidget(const MyApp());
//     expect(find.text('My Cards'), findsOneWidget);
//
//     // Find the add new card floating action button.
//     expect(find.byKey(const Key('add_new_card_fab')), findsOneWidget);
//
//     // when
//     await tester.tap(find.byType(FloatingActionButton));
//     await tester.pump();
//     await tester.pumpAndSettle()
//
//     // then
//     expect(find.text('Scan'), findsOneWidget);
//     expect(find.text('Save Card'), findsOneWidget);
//   });
//
//   testWidgets('GIVEN user is on the MyCards Screen'
//       'WHEN the user taps the `+` floating action button'
//       'THEN we navigate the user to the add a new card screen', (tester) async {
//
//     // given
//     await tester.pumpWidget(const ());
//     expect(find.text('My Cards'), findsOneWidget);
//
//     // Find the add new card floating action button.
//     expect(find.byKey(const Key('add_new_card_fab')), findsOneWidget);
//
//     // when
//     await tester.tap(find.byType(FloatingActionButton));
//     await tester.pump();
//     await tester.pumpAndSettle()
//
//     // then
//     expect(find.text('Scan'), findsOneWidget);
//     expect(find.text('Save Card'), findsOneWidget);
//   });
// }
