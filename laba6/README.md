марсаход поменял на сuriosity так как opportunity не работает в json файле ответ не отправляет на фото
Управление состоянием происходичт через cubit
abstract class NasaState {}
class NasaLoading extends NasaState {}
class NasaLoaded extends NasaState { ... }
class NasaError extends NasaState { ... }

class NasaCubit extends Cubit<NasaState> {
  void fetchData() async { ... }
}
     
