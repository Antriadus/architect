import 'package:example/domain/user/user.dart';
import 'package:example/domain/user/user_repository.dart';

class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User> call(int id) => _repository.getById(id);
}
