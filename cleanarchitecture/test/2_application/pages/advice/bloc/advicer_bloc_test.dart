import 'package:cleanarchitecture/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Advicer Bloc', () {
    group('Should emits', () {
      blocTest<AdvicerBloc, AdvicerState>(
        'nothing happened when no event is added',
        build: () => AdvicerBloc(),
        expect: () => const <AdvicerState>[],
      );

      blocTest<AdvicerBloc, AdvicerState>(
        '[AdvicerLoadingState, AdvicerStateError] when AdviceREquestedEvent is added',
        build: () => AdvicerBloc(),
        act: (bloc) => bloc.add(AdviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdvicerState>[AdvicerStateLoading(), AdvicerStateError(message: 'error message')],
      );
    });
  });
}
