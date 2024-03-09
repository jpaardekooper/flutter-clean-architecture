import 'package:cleanarchitecture/1_domain/entities/advice_entity.dart';
import 'package:cleanarchitecture/1_domain/failures/failures.dart';
import 'package:cleanarchitecture/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return await adviceRepo.getAdviceFromDatasource();
  }
}
