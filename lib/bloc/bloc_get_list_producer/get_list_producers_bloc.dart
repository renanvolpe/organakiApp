import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/services/producer_services.dart';

part 'get_list_producers_event.dart';
part 'get_list_producers_state.dart';

class GetListProducersBloc
    extends Bloc<GetListProducersEvent, GetListProducersState> {
  GetListProducersBloc(ProducerRepository producerRepository)
      : super(GetListProducersInitial()) {
    on<GetListProducersStart>((event, emit) async {
      emit(GetListProducersProgress());
      var response = await producerRepository.getListProducers();
      response.fold((success) => emit(GetListProducersSuccess(success)),
          (failure) => emit(GetListProducersFailure(failure)));
    });
  }
}
