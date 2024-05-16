import 'package:http/http.dart' as http;
import 'dart:convert';


Future<int> registerUser(String firstName, String lastName, String email,
    String password, List<String> roles) async {
  var url = Uri.parse('https://s3-5193.nuage-peda.fr/users');
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'roles': roles
  });
  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      print(
          "Query failed : Code status ${response.statusCode}, Response : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception during query : $e");
    return 0;
  }
}

Future<int> loginUser(String email, String password) async {
  var url = Uri.parse('https://s3-5193.nuage-peda.fr/users/login');
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({
    'email': email,
    'password': password,
  });
  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      print(
          "Query failed : Code status ${response.statusCode}, Response : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception during query : $e");
    return 0;
  }
}
