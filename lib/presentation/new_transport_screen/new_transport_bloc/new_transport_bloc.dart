import 'package:bloc/bloc.dart';
import 'package:boat_rent/data/data_manager.dart';
import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:flutter/material.dart';

part 'new_transport_event.dart';

part 'new_transport_state.dart';

class NewTransportBloc extends Bloc<NewTransportEvent, NewTransportState> {
  NewTransportBloc() : super(NewTransportMainInfoState()) {
    on<NewTransportMainEvent>(_onMainInfoScreenLaunch);
    on<NewTransportSecondEvent>(_onSecondInfoScreenLaunch);
    on<NewTransportEndEvent>(_onEndLaunch);
  }

  _onMainInfoScreenLaunch(
      NewTransportMainEvent event, Emitter<NewTransportState> emit) {
    emit(NewTransportMainInfoState());
  }

  _onSecondInfoScreenLaunch(
      NewTransportSecondEvent event, Emitter<NewTransportState> emit) {
    emit(NewTransportSecondaryInfoState(
        typeBoat: event.typeBoat,
        rentalCost: event.rentalCost,
        whoRents: event.whoRents,
        paymentType: event.paymentType));
  }

  _onEndLaunch(NewTransportEndEvent event, Emitter<NewTransportState> emit) {
    DataManager.addBoatToList(event.boatModel);
  }
}
