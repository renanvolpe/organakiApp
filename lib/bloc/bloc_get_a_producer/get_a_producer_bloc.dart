import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/services/producer_services.dart';

part 'get_a_producer_event.dart';
part 'get_a_producer_state.dart';

class GetAProducerBloc extends Bloc<GetAProducerEvent, GetAProducerState> {
  GetAProducerBloc(ProducerRepository producerRepository)
      : super(GetAProducerInitial()) {
    on<GetAProducerStart>((event, emit) async {
      emit(GetAProducerProgress());
      var response = await producerRepository.getAProducer(event.id);
      response.fold((success) => emit(GetAProducerSuccess(success)),
          (failure) => emit(GetAProducerFailure(failure)));
      // do call to get a producer here :)
      // see listProducer as example to proceed that
    });
  }
}
