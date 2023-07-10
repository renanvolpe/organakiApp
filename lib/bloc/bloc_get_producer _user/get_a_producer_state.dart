part of 'get_a_producer_bloc.dart';

@immutable
abstract class GetProducerUserState {}

class GetProducerUserInitial extends GetProducerUserState {}

class GetProducerUserProgress extends GetProducerUserState {}

class GetProducerUserSuccess extends GetProducerUserState {
  final Producer producer;

  GetProducerUserSuccess(this.producer);
}

class GetProducerUserFailure extends GetProducerUserState {
  final String errorMessage;
  GetProducerUserFailure(this.errorMessage);
}
