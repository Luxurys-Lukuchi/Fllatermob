import 'package:equatable/equatable.dart';

abstract class InterestState extends Equatable {
  const InterestState();
}

class InterestInitial extends InterestState {
  @override
  List<Object> get props => [];
}

class InterestAgreementUpdated extends InterestState {
  final bool agreed;
  const InterestAgreementUpdated({required this.agreed});

  @override
  List<Object> get props => [agreed];
}

class InterestCalculated extends InterestState {
  final double capital;
  final double term;
  final double rate;
  final double interest;
  final bool agreed;

  const InterestCalculated({
    required this.capital,
    required this.term,
    required this.rate,
    required this.interest,
    required this.agreed,
  });

  @override
  List<Object> get props => [capital, term, rate, interest, agreed];
}