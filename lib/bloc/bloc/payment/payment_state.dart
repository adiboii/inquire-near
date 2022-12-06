// ignore_for_file: must_be_immutable

part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  int retries = 0;

  PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class Loading extends PaymentState {}

class PaymentError extends PaymentState {
  PaymentError() {
    retries++;
  }
}

class PaymentSuccessful extends PaymentState {}

class PayoutSuccessful extends PaymentState {}

class PayoutFailed extends PaymentState {}
