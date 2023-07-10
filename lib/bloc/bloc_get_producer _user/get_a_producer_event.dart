part of 'get_a_producer_bloc.dart';

@immutable
abstract class GetProducerUserEvent {}

class GetProducerUserStart extends GetProducerUserEvent {
  final String id; //id of Producer here
  GetProducerUserStart({
    required this.id,
  });
}
