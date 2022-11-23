part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class Loading extends PaymentState {}

class PaymentError extends PaymentState {}

class PaymentSuccessful extends PaymentState {}

class PayoutSuccessful extends PaymentState {}

class PayoutFailed extends PaymentState {}
