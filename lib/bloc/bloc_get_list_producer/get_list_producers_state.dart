part of 'get_list_producers_bloc.dart';

@immutable
abstract class GetListProducersState {}

class GetListProducersInitial extends GetListProducersState {}

class GetListProducersProgress extends GetListProducersState {}

class GetListProducersSuccess extends GetListProducersState {
  final List<Producer> listProducers;
  GetListProducersSuccess(this.listProducers);
}

class GetListProducersFailure extends GetListProducersState {
  final String errorMessage;
  GetListProducersFailure(this.errorMessage);
}
