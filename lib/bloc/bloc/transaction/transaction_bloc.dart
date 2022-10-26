import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  //TODO: get hiringRequest data from previous screen
  HiringRequest? hiringRequest;
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  String? store;
  TransactionBloc(
      {required this.transactionRepository, required this.userRepository})
      : super(TransactionInitial()) {
    on<GetHiringRequestDetails>(_onGetHiringDetails);
    on<GetTransactionDetails>(_onGetTransactionDetails);
    on<ClickStore>(_onClickStore);
  }

  void _onGetHiringDetails(GetHiringRequestDetails event, emit) async {
    emit(Retrieving());
    hiringRequest = event.hiringRequest;
    emit(RetreievedHiringRequestDetails());
  }

  void _onClickStore(ClickStore event, emit) async {
    store = event.store;
  }

  void _onGetTransactionDetails(GetTransactionDetails event, emit) async {
    emit(Retrieving());

    INTransaction transaction = await transactionRepository
        .getTransactionDetails(hiringRequest!.transactionId);

    transaction.uid = hiringRequest!.transactionId;

    Map<String, dynamic> userData =
        await userRepository.getUserData(hiringRequest!.clientId);

    InquiryList inquiryList =
        await transactionRepository.getInquiryList(transaction.inquiryListID);

    inquiryList.uid = transaction.inquiryListID;

    emit(RetrievedTransactionDetails(
      transaction: transaction,
      userData: userData,
      inquiryList: inquiryList,
    ));
  }
}
