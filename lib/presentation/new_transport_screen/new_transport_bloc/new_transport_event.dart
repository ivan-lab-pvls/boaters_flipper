part of 'new_transport_bloc.dart';

@immutable
sealed class NewTransportEvent {}

class NewTransportMainEvent extends NewTransportEvent {}

class NewTransportSecondEvent extends NewTransportEvent {
  final String typeBoat;
  final double rentalCost;
  final String whoRents;
  final PaymentType paymentType;

  NewTransportSecondEvent({required this.typeBoat, required this.rentalCost, required this.whoRents, required this.paymentType});
}

class NewTransportEndEvent extends NewTransportEvent {
  final BoatModel boatModel;

  NewTransportEndEvent({required this.boatModel});
}
