import 'package:flutter_soft_wars/core/usecase/usecase.dart';

import 'package:flutter_soft_wars/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetEmailUseCase extends ExecuteUseCase<String?> {
  const GetEmailUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String?> execute() async => _authRepository.getEmail();
}
