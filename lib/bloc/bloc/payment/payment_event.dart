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

class Payout extends PaymentEvent {
  final String clientName;
  final String transactionId;
  final String inquirerPayPalEmail;
  final double amount;

  const Payout(this.clientName, this.transactionId, this.inquirerPayPalEmail,
      this.amount);
}
