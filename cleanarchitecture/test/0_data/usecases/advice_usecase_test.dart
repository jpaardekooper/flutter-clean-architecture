import 'package:cleanarchitecture/0_data/repositories/advice_repo_impl.dart';
import 'package:cleanarchitecture/1_domain/entities/advice_entity.dart';
import 'package:cleanarchitecture/1_domain/failures/failures.dart';
import 'package:cleanarchitecture/1_domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUseCase test', () {
    group('Should return AdviceEntity', () {
      test('when ADviceRepoImpl returns a Advice model', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
          (realInvocation) => Future.value(
            const Right(
              AdviceEntity(advice: 'advice test', id: 1),
            ),
          ),
        );

        final result = await adviceUseCaseUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);

        expect(result, const Right<Failure, AdviceEntity>(AdviceEntity(advice: 'advice test', id: 1)));
        verifyNever(mockAdviceRepoImpl
            .adviceRemoteDatasource); //verify when you want to check if a method was not called use verifyuNEver(mock.,calll) instead ,caklked*(0)
      });
    });

    group('Should return Left side', () {
      test('when a ServerFailure occurs', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
          (realInvocation) => Future.value(
            Left(ServerFailure('server failure')),
          ),
        );

        final result = await adviceUseCaseUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);

        expect(result, Left<Failure, AdviceEntity>(ServerFailure('server failure')));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource());
        verifyNoMoreInteractions(mockAdviceRepoImpl);
        //verify when you want to check if a method was not called use verifyuNEver(mock.,calll) instead ,caklked*(0)
      });

      test('when a GeneralFailure occurs', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCaseUnderTest = AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
          (realInvocation) => Future.value(
            Left(GeneralFailure('general failure')),
          ),
        );

        final result = await adviceUseCaseUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);

        expect(result, Left<Failure, AdviceEntity>(GeneralFailure('general failure')));
        verify(mockAdviceRepoImpl.getAdviceFromDatasource());
        verifyNoMoreInteractions(mockAdviceRepoImpl);
        //verify when you want to check if a method was not called use verifyuNEver(mock.,calll) instead ,caklked*(0)
      });
    });
  });
}
