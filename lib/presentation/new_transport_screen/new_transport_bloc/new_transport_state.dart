part of 'new_transport_bloc.dart';

@immutable
sealed class NewTransportState {}

final class NewTransportMainInfoState extends NewTransportState {
}

final class NewTransportSecondaryInfoState extends NewTransportState {
  final String typeBoat;
  final double rentalCost;
  final String whoRents;
  final PaymentType paymentType;

  NewTransportSecondaryInfoState({required this.typeBoat, required this.rentalCost, required this.whoRents, required this.paymentType});

}
