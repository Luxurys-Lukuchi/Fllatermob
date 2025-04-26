Отличия 4 от 3 лабораторной работы
Использование Cubit
                                                                                                                                        
                                                                                                                                            Реализован InterestCubit, управляющий состояниями (InterestInitial, InterestAgreementUpdated, InterestCalculated).

    Состояния наследуются от Equatable для оптимизации сравнения.

Отделение логики от представления

    Логика вынесена в InterestCubit.

    UI только отображает данные и передает действия в Cubit (через context.read<InterestCubit>()).

Смена состояний

    Все состояния приложения управляются через Cubit.

    Используется BlocBuilder для обновления UI.

Другое

    Расчет процентов выполняется в Cubit (calculateInterest).

    Нет переключения экранов — вместо этого меняются состояния (например, переход от InterestInitial к InterestCalculated).
