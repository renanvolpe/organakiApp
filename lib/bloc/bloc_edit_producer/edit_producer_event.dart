part of 'edit_producer_bloc.dart';

@immutable
abstract class EditProducerEvent {}

class EditProducerStart extends EditProducerEvent {
  final Producer producer;
  final String token;
  EditProducerStart(this.producer, this.token);
}
