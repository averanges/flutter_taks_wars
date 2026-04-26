import 'package:flutter_soft_wars/core/usecase/usecase.dart';

import 'package:flutter_soft_wars/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SignInWithEmailUseCase extends UseCase<void, String> {
  const SignInWithEmailUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call(String email) => _authRepository.signInWithEmail(email);
}
