import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class SignUpController extends GetxController {
  bool _signUpApiInProgress = false;
  String _errorMessage = '';

  bool get signUpApiInProgress => _signUpApiInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _signUpApiInProgress = true;
    update();

    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": "",
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Registration failed! Try again';
    }

    _signUpApiInProgress = false;
    update();

    return isSuccess;
  }
}
