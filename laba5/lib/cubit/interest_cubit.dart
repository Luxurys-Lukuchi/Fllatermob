import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/db_provider.dart';
import 'interest_state.dart';
import '../models/calculation.dart';

class InterestCubit extends Cubit<InterestState> {
  final DBProvider dbProvider;
  
  InterestCubit(this.dbProvider) : super(const InterestInitial());

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
  }) async {
    try {
      final interest = (capital * term * rate) / 100;
      final agreed = state is InterestAgreementUpdated 
          ? (state as InterestAgreementUpdated).agreed
          : false;
      
      final calculation = Calculation(
        capital: capital,
        term: term,
        rate: rate,
        interest: interest,
        date: DateTime.now(),
      );
      
      await dbProvider.addCalculation(calculation);
      
      emit(InterestCalculated(
        capital: capital,
        term: term,
        rate: rate,
        interest: interest,
        agreed: agreed,
      ));
    } catch (e) {
      emit(InterestError(message: 'Ошибка при расчете: $e'));
    }
  }

  void loadHistory() async {
    try {
      final calculations = await dbProvider.getAllCalculations();
      emit(HistoryLoaded(calculations: calculations));
    } catch (e) {
      emit(InterestError(message: 'Ошибка при загрузке истории: $e'));
    }
  }

  void deleteCalculation(int id) async {
    try {
      await dbProvider.deleteCalculation(id);
      loadHistory();
    } catch (e) {
      emit(InterestError(message: 'Ошибка при удалении: $e'));
    }
  }

  void clearHistory() async {
    try {
      await dbProvider.clearAllCalculations();
      loadHistory();
    } catch (e) {
      emit(InterestError(message: 'Ошибка при очистке: $e'));
    }
  }

  void reset() => emit(const InterestInitial());
}
