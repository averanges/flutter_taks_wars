sealed class ValidationFailure {
  const ValidationFailure(this.message);
  final String message;
}

class RequiredFieldFailure extends ValidationFailure {
  const RequiredFieldFailure([String? field]) : super('$field обов’язково');
}

class EmptyEmailFailure extends ValidationFailure {
  const EmptyEmailFailure() : super('Введіть email');
}

class InvalidEmailFormatFailure extends ValidationFailure {
  const InvalidEmailFormatFailure() : super('Невірний формат пошти');
}

class UnknownFailure extends ValidationFailure {
  const UnknownFailure() : super('Щось пішло не так');
}
