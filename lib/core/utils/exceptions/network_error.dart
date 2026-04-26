import 'package:equatable/equatable.dart';

class NetworkError extends Equatable {
  const NetworkError({required this.error});

  final String error;

  String get userMessage {
    return switch (error) {
      'ERR002' => 'Метод не підтримується сервером',
      'ERR003' => 'Доступ заборонено',
      'ERR004' => 'Помилка на сервері',
      'ERR005' => 'Помилка бази даних',
      'ERR007' => 'Запитувана адреса не знайдена',
      'ERR024' => 'Невірний ідентифікатор задачі',
      'ERR038' => 'Один або кілька елементів масиву некоректні',
      'ERR999' => 'Невідома помилка сервера',
      _ => '',
    };
  }

  bool get isUnauthorized => error == 'ERR002';
  bool get isForbidden => error == 'ERR003';
  bool get isNotFound => error == 'ERR007';
  bool get isValidationError => <String>['ERR024', 'ERR038'].contains(error);

  @override
  List<Object?> get props => [error];
}
