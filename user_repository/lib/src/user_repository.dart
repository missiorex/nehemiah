import 'models/models.dart';

abstract class UsersRepository {
  Future<bool> isAuthenticated();

  Future<void> authenticate();

  Future<String> getUserId();

  //Child
  Future<void> addNewChild(Child child, String userId);

  Future<void> deleteChild(Child child);

  Stream<List<Child>> children(String userId);

  Future<void> updateChild(Child child);
}
