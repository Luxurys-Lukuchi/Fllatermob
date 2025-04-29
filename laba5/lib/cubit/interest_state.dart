import 'package:equatable/equatable.dart';
import '../models/calculation.dart';

abstract class InterestState extends Equatable {
  const InterestState();
  
  @override
  List<Object> get props => [];
}

class InterestInitial extends InterestState {
  const InterestInitial();
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

class HistoryLoaded extends InterestState {
  final List<Calculation> calculations;
  
  const HistoryLoaded({required this.calculations});
  
  @override
  List<Object> get props => [calculations];
}

class InterestError extends InterestState {
  final String message;
  
  const InterestError({required this.message});
  
  @override
  List<Object> get props => [message];
}