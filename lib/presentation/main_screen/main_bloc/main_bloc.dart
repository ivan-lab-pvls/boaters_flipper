import 'package:bloc/bloc.dart';
import 'package:boat_rent/data/data_manager.dart';
import 'package:meta/meta.dart';

import '../../../data/models/boat_model/boat_model.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitialState()) {
    on<MainGetEvent>(_onGetData);
  }

  _onGetData(MainGetEvent event, Emitter<MainState> emit) async {
    emit(MainLoadingState());

    List<BoatModel> boatModels =   await DataManager.loadBoatList();

    if (boatModels.isEmpty) {
      emit(MainLoadedEmptyState());
    } else {
      emit(MainLoadedFullState(boatModelList: boatModels));
    }
  }
}
