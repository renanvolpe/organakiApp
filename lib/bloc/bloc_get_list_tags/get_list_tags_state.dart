part of 'get_list_tags_bloc.dart';

@immutable
abstract class GetListTagsState {}

class GetListTagsInitial extends GetListTagsState {}

class GetListTagsProgress extends GetListTagsState {}

class GetListTagsSuccess extends GetListTagsState {
  final List<String> listTags;
  GetListTagsSuccess(this.listTags);
}

class GetListTagsFailure extends GetListTagsState {
  final String errorMessage;
  GetListTagsFailure(this.errorMessage);
}
