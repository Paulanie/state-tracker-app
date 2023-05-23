
import 'package:bloc/bloc.dart';
import 'package:state_tracker_app/api/state_tracker.swagger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required StateTracker api}) : _api = api, super(HomeInitial()) {
    on<HomeRefresh>(_onRefreshAsked);
  }

  final StateTracker _api;

  _onRefreshAsked(HomeRefresh event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    await emit.forEach(
        _api.amendmentsGet(page: event.page, size: event.pageSize).asStream(),
        onData: (data) => HomeData(data.body?.records ?? []),
        onError: (error, stackTrace) => HomeError(error.toString()),
    );
  }
}
