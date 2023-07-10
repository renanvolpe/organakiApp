part of 'get_a_producer_bloc.dart';

@immutable
abstract class GetAProducerEvent {}

class GetAProducerStart extends GetAProducerEvent {
  final String id; //id of Producer here
  GetAProducerStart({
    required this.id,
  });
}
