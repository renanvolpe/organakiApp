part of 'get_a_producer_bloc.dart';

@immutable
abstract class GetAProducerState {}

class GetAProducerInitial extends GetAProducerState {}

class GetAProducerProgress extends GetAProducerState {}

class GetAProducerSuccess extends GetAProducerState {
  final Producer producer;

  GetAProducerSuccess(this.producer);
}

class GetAProducerFailure extends GetAProducerState {
  final String errorMessage;
  GetAProducerFailure(this.errorMessage);
}
