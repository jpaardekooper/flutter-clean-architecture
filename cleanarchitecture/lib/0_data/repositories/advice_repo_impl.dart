import 'package:cleanarchitecture/0_data/datasources/advice_remote_datasource.dart';
import 'package:cleanarchitecture/0_data/exceptions/exceptions.dart';
import 'package:cleanarchitecture/1_domain/failures/failures.dart';
import 'package:cleanarchitecture/1_domain/entities/advice_entity.dart';
import 'package:cleanarchitecture/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure(_.toString()));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }
}
