import 'package:example/domain/user/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();

  Future<User> getById(int id);
}
