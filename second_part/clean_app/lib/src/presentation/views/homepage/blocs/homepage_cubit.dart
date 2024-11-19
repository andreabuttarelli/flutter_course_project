import 'package:clean_app/src/domain/usecases/get_user_id_usecase.dart';
import 'package:clean_app/src/domain/usecases/usecase.dart';
import 'package:clean_app/src/presentation/views/homepage/blocs/homepage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._getUserID) : super(const HomePageStateInitial());

  final GetUserIDUseCase _getUserID;

  void retrieveUserID() => _getUserID.call(UseCaseParams.empty()).then(
        (res) => res.fold(
          (l) => addError(l, StackTrace.current),
          (r) => emit(
            HomePageStateLoaded(r.id),
          ),
        ),
      );

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    emit(HomePageStateError(error as Exception));
  }
}
