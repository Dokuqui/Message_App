import 'package:flutter/material.dart';
import 'package:message_app/api/user.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedRole = 'user';
  bool _agreeToTerms = false;
  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        print(
            "${_firstNameController.text}, ${_lastNameController.text},${_emailController.text},${_passwordController.text} ");
        int result = await registerUser(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            _passwordController.text,
            [_selectedRole]);
        Navigator.of(context).pop();
        if (result == 201) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Inscription received'),
              content: Text(
                  'Hello, ${_firstNameController.text} ${_lastNameController.text}!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushReplacementNamed('/login')
                  },
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Problem with inscription'),
              content: Text(
                  'Exist an error: ${result.toString()}. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Error exist during inscription: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Type your surname';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Please use only letters';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Type your name';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Please use only letters';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Type your email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter valid email format';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please type password';
                }
                if (value.length < 12) {
                  return 'Password should be at least 12 characters length';
                }
                if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                  return 'In password should be at least one small letter';
                }
                if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                  return 'In password should be at least one caps letter';
                }
                if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                  return 'In password should be at least one number';
                }
/*                if (!RegExp(r'(?=.*[\W])').hasMatch(value)) {
                  return 'In password should be at least one special character';
                }*/
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm your password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please type your password';
                } else if (value != _passwordController.text) {
                  return 'Password isn\'t same';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Role:'),
              subtitle: DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: <String>['user', 'admin'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Accept terms and conditions'),
              value: _agreeToTerms,
              onChanged: (bool? newValue) {
                setState(() {
                  _agreeToTerms = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agreeToTerms ? _submitForm : null,
              child: const Center(child: Text('Registered')),
            ),
          ],
        ),
      ),
    );
  }
}
