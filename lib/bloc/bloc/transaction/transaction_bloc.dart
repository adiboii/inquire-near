// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:inquire_near/data/models/hiring_request.dart';
import 'package:inquire_near/data/models/inquiry_list.dart';
import 'package:inquire_near/data/models/transaction.dart';
import 'package:inquire_near/data/repositories/transaction_repository.dart';
import 'package:inquire_near/data/repositories/user_repository.dart';
import 'package:inquire_near/enums/hiring_request_status.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  //TODO: get hiringRequest data from previous screen
  HiringRequest? hiringRequest;
  final TransactionRepository transactionRepository;
  final UserRepository userRepository;
  TransactionBloc(
      {required this.transactionRepository, required this.userRepository})
      : super(TransactionInitial()) {
    hiringRequest = HiringRequest(
        clientId: "4Ltsqt5nyNZA4jfBv3ogQ68yyVg1",
        inquirerId: "hsF8cjt9DreKqy6fctdPrMBjdGI2",
        transactionId: "rNZ74JZFPx4wXyysOrnr",
        status: HiringRequestStatus.pending);

    hiringRequest!.setId("6H6SNAeBFdne0cB54ITF");

    on<GetTransactionDetails>(_onGetHiringDetails);
  }

  void _onGetHiringDetails(GetTransactionDetails event, emit) async {
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
