import 'package:flutter_bloc/flutter_bloc.dart';
import 'interest_state.dart';

class InterestCubit extends Cubit<InterestState> {
  InterestCubit() : super(InterestInitial());

  void setAgreed(bool agreed) {
    if (state is InterestCalculated) {
      final current = state as InterestCalculated;
      emit(InterestCalculated(
        capital: current.capital,
        term: current.term,
        rate: current.rate,
        interest: current.interest,
        agreed: agreed,
      ));
    } else {
      emit(InterestAgreementUpdated(agreed: agreed));
    }
  }

  void calculateInterest({
    required double capital,
    required double term,
    required double rate,
  }) {
    final interest = (capital * term * rate) / 100;
    final agreed = state is InterestAgreementUpdated 
        ? (state as InterestAgreementUpdated).agreed
        : false;
    emit(InterestCalculated(
      capital: capital,
      term: term,
      rate: rate,
      interest: interest,
      agreed: agreed,
    ));
  }

  void reset() => emit(InterestInitial());
}
