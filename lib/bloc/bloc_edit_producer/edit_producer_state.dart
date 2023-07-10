part of 'edit_producer_bloc.dart';

@immutable
abstract class EditProducerState {}

class EditProducerInitial extends EditProducerState {}

class EditProducerProgress extends EditProducerState {}

class EditProducerSuccess extends EditProducerState {
  final String successMessage;
  EditProducerSuccess(this.successMessage);
}

class EditProducerFailure extends EditProducerState {
  final String errorMessage;
  EditProducerFailure(this.errorMessage);
}
