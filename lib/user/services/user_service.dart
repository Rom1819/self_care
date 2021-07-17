import 'package:self_care/user/models/user.dart';
import 'package:self_care/user/repositories/repository.dart';

class UserService {
  Repository _repository;

  UserService() {
    _repository = Repository();
  }

  //  Create data
  saveUser(User user) async {
    return await _repository.insertData('user', user.userMap());
  }

  //  Read data from table
  readUser() async {
    return _repository.readData('user');
  }

  readUserById(userId) async {
    return await _repository.readDataById('user', userId);
  }

  updateUser(User user) async {
    return await _repository.updateUser('user', user.userMap());
  }
}
