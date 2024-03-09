import 'package:cleanarchitecture/1_domain/entities/advice_entity.dart';
import 'package:cleanarchitecture/1_domain/failures/failures.dart';
import 'package:cleanarchitecture/1_domain/usecases/advice_usecases.dart';
import 'package:cleanarchitecture/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('Advice Cubit', () {
    MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

    group('Should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        expect: () => const <AdvicerCubitState>[],
      );

      blocTest(
        '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'test', id: 1),
            ),
          ),
        ),
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect: () => <AdvicerCubitState>[AdvicerStateLoading(), const AdvicerStateLoaded(advice: 'test')],
      );
    });

    group('[AdvicerStateLoading, AdvicerStateError] when adviceRequest is called', () {
      blocTest(
        'when a serverFailure occures',
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            Left<Failure, AdviceEntity>(
              ServerFailure('Server Failure occured'),
            ),
          ),
        ),
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect: () => <AdvicerCubitState>[
          AdvicerStateLoading(),
          const AdvicerStateError(message: serverFailureMessage),
        ],
      );

      blocTest(
        'when a cache failure occures',
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            Left<Failure, AdviceEntity>(
              CacheFailure('Cache failure occured'),
            ),
          ),
        ),
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect: () => <AdvicerCubitState>[
          AdvicerStateLoading(),
          const AdvicerStateError(message: cacheFailureMessage),
        ],
      );

      blocTest(
        'when a General failure occures',
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            Left<Failure, AdviceEntity>(
              GeneralFailure('General  failure occureed'),
            ),
          ),
        ),
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect: () => <AdvicerCubitState>[
          AdvicerStateLoading(),
          const AdvicerStateError(message: generalFailureMessage),
        ],
      );
    });
  });
}
