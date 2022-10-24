part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class Pay extends PaymentEvent {
  final double amount;
  final String transactionId;

  const Pay(this.amount, this.transactionId);
}
