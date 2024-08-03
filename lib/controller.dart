import 'package:hive/hive.dart';

class HiveController {
  final Box _box = Hive.box('mybox');

  void writeData(
      {required String username,
      required String email,
      required String password}) {
    var userMap = {"username": username, "email": email, "password": password};
    _box.put('userdetails', userMap);
  }

  dynamic readData() {
    var userDetails = _box.get('userdetails');
    if (userDetails == null || userDetails.isEmpty) {
      return ('Enter Data');
    } else {
      return userDetails;
    }
  }

  void deleteData() {
    _box.delete('userdetails');
  }
}
