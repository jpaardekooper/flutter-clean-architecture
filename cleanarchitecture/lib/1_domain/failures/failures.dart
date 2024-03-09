import 'package:equatable/equatable.dart';

abstract class Failure {
  final String? stackTrace;

  Failure(this.stackTrace);
}

class ServerFailure extends Failure with EquatableMixin {
  ServerFailure(super.stackTrace);

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure with EquatableMixin {
  CacheFailure(super.stackTrace);

  @override
  List<Object?> get props => [];
}

class GeneralFailure extends Failure with EquatableMixin {
  GeneralFailure(super.stackTrace);

  @override
  List<Object?> get props => [];
}
