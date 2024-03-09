import 'dart:math';

import 'package:cleanarchitecture/2_application/core/services/theme_service.dart';
import 'package:cleanarchitecture/2_application/pages/advice/advice_page.dart';
import 'package:cleanarchitecture/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:cleanarchitecture/2_application/pages/advice/widgets/advice_field.dart';
import 'package:cleanarchitecture/2_application/pages/advice/widgets/error_message.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdvicerCubitState> implements AdvicerCubit {}

void main() {
  Widget widgetUnderTest({required AdvicerCubit cubit}) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider<AdvicerCubit>(
          create: (context) => cubit,
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeService(),
        ),
      ],
      child: const AdvicerPage(),
    ));
  }

  group('AdvicerPage', () {
    late AdvicerCubit mockAdvicerCubit;

    setUp(() {
      mockAdvicerCubit = MockAdvicerCubit();
    });

    group('Should be displayed in ViewState', () {
      testWidgets('Initial when cubits Emits AdvicerInitial()', (widgetTester) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable(
            [AdvicerInitial()],
          ),
          initialState: AdvicerInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));

        final advicerInitialTextFinder = find.text('Your Advice is waiting for you!');

        expect(advicerInitialTextFinder, findsOneWidget);
      });

      testWidgets('Initial when cubits Emits AdvicerLoadingState()', (widgetTester) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable(
            [AdvicerStateLoading()],
          ),
          initialState: AdvicerInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerWidgetFinder = find.byType(CircularProgressIndicator);

        expect(advicerWidgetFinder, findsOneWidget);
      });

      testWidgets('Initial when cubits Emits AdvicerLoadedState()', (widgetTester) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable([const AdvicerStateLoaded(advice: 'test')]),
          initialState: AdvicerInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerTextFinder = find.text('test');
        final advicerWidgetFinder = find.byType(AdviceField);
        final advicerText = widgetTester.widget<AdviceField>(advicerWidgetFinder).advice;

        expect(advicerTextFinder, findsOneWidget);

        expect(advicerWidgetFinder, findsOneWidget);

        expect(advicerText, 'test');
      });

      testWidgets('Initial when cubits Emits AdvicerErrorState()', (widgetTester) async {
        whenListen(
          mockAdvicerCubit,
          Stream.fromIterable([const AdvicerStateError(message: 'test error')]),
          initialState: AdvicerInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();

        final advicerErrorWidgetFinder = find.byType(ErrorMessage);
        final advicerText = widgetTester.widget<ErrorMessage>(advicerErrorWidgetFinder).message;

        expect(advicerErrorWidgetFinder, findsOneWidget);

        expect(advicerText, 'test error');
      });
    });
  });
}
