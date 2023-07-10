import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/services/producer_services.dart';

part 'get_a_producer_event.dart';
part 'get_a_producer_state.dart';

class GetProducerUserBloc extends Bloc<GetProducerUserEvent, GetProducerUserState> {
  GetProducerUserBloc(ProducerRepository producerRepository)
      : super(GetProducerUserInitial()) {
    on<GetProducerUserStart>((event, emit) async {
      emit(GetProducerUserProgress());
      var response = await producerRepository.getAProducer(event.id);
      response.fold((success) => emit(GetProducerUserSuccess(success)),
          (failure) => emit(GetProducerUserFailure(failure)));
      // do call to get a producer here :)
      // see listProducer as example to proceed that
    });
  }
}
