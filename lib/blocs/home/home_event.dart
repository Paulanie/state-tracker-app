part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeRefresh implements HomeEvent {
  final int page;
  final int pageSize;

  HomeRefresh(this.page, this.pageSize);

}
