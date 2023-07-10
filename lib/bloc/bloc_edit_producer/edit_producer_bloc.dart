import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/services/producer_services.dart';

part 'edit_producer_event.dart';
part 'edit_producer_state.dart';

class EditProducerBloc extends Bloc<EditProducerEvent, EditProducerState> {
  EditProducerBloc(ProducerRepository producerRepository)
      : super(EditProducerInitial()) {
    on<EditProducerStart>((event, emit) async {
      emit(EditProducerProgress());
      var response =
          await producerRepository.editProducer(event.producer, event.token);
      response.fold((success) => emit(EditProducerSuccess(success)),
          (failure) => EditProducerFailure(failure));
    });
  }
}
