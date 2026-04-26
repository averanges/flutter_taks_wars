import 'package:flutter_soft_wars/core/utils/constants.dart';
import 'package:flutter_soft_wars/core/utils/validators/validation_failure.dart';

class FieldValidator {
  const FieldValidator._();

  static ValidationFailure? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return RequiredFieldFailure(fieldName ?? 'Це поле');
    }
    return null;
  }

  static ValidationFailure? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    const pattern = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

    if (!RegExp(pattern).hasMatch(value.trim())) {
      return const InvalidEmailFormatFailure();
    }
    return null;
  }

  static ValidationFailure? combine(List<ValidationFailure? Function()> validators) {
    for (final value in validators) {
      final failure = value();
      if (failure != null) return failure;
    }
    return null;
  }

  static ValidationFailure? validateEmail(String raw) {
    final failure = combine([() => required(raw, Constants.email), () => email(raw)]);

    if (failure != null) {
      return failure;
    }

    return null;
  }
}
