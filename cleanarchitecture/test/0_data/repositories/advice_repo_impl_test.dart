import 'dart:io';

import 'package:cleanarchitecture/0_data/datasources/advice_remote_datasource.dart';
import 'package:cleanarchitecture/0_data/exceptions/exceptions.dart';
import 'package:cleanarchitecture/0_data/models/advice_model.dart';
import 'package:cleanarchitecture/0_data/repositories/advice_repo_impl.dart';
import 'package:cleanarchitecture/1_domain/entities/advice_entity.dart';
import 'package:cleanarchitecture/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('Should return Advice entity', () {
      test('when AdviceRemoteDatasource reutrns a AdviceModel', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();

        final adviceRepoImlUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.value(
            AdviceModel(advice: 'test', id: 1),
          ),
        );

        final result = await adviceRepoImlUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result, Right<Failure, AdviceEntity>(AdviceModel(advice: 'test', id: 1)));

        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });

    group('Should return left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();

        final adviceRepoImlUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenThrow(ServerException());

        final result = await adviceRepoImlUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure('Server failure')));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();

        final adviceRepoImlUnderTest = AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test General failure'));

        final result = await adviceRepoImlUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure('General failure')));
      });
    });
  });
}
