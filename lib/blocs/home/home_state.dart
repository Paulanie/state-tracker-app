part of 'home_bloc.dart';

sealed class HomeState {}

class HomeInitial implements HomeState {}

class HomeLoading implements HomeState {}
class HomeData implements HomeState {
  final List<AmendmentsDTO> amendments;

  HomeData(this.amendments);
}

class HomeError implements HomeState {
  final String message;

  HomeError(this.message);
}