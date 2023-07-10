import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:organaki_app/services/producer_services.dart';

part 'get_list_tags_event.dart';
part 'get_list_tags_state.dart';

class GetListTagsBloc extends Bloc<GetListTagsEvent, GetListTagsState> {
  GetListTagsBloc(ProducerRepository producerRepository)
      : super(GetListTagsInitial()) {
    on<GetListTagsStart>((event, emit) async {
      emit(GetListTagsProgress());
      producerRepository = ProducerRepository();
      var response = await producerRepository.getTags();
      response.fold((success) => emit(GetListTagsSuccess(success)),
          (failure) => GetListTagsFailure(failure));
    });
  }
}
