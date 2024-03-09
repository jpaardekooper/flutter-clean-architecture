import 'package:cleanarchitecture/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String adviceText}) {
    return MaterialApp(
      home: AdviceField(advice: adviceText),
    );
  }

  group('AdviceField', () {
    group('should be displayed correctly', () {
      testWidgets('When a short text is given', (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text('a');

        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('When a long text is given', (widgetTester) async {
        const text =
            'Hello Developers this is the widget test for AdviceField,Hello Developers this is the widget test for AdviceField,Hello Developers this is the widget test for AdviceField';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(AdviceField);

        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('When no text is given', (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text(AdviceField.emptyAdvice);
        final adviceText = widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, '');
      });
    });
  });
}
