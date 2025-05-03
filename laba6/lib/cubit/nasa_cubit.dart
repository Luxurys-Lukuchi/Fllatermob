import 'package:flutter_bloc/flutter_bloc.dart';
import '../requests/api.dart';
import '../models/nasa_response.dart';

abstract class NasaState {}

class NasaLoading extends NasaState {}

class NasaLoaded extends NasaState {
  final NasaResponse data;
  NasaLoaded(this.data);
}

class NasaError extends NasaState {
  final String message;
  NasaError(this.message); 
}

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaLoading());

  void fetchData() async {
    try {
      final data = await ApiService.getPhotos();
      emit(NasaLoaded(data));
    } catch (e) {
      emit(NasaError('Ошибка: $e'));
    }
  }
}
