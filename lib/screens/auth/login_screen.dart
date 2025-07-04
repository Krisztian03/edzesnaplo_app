import 'package:flutter/material.dart';

import '../../../cores/services/auth_service.dart';
import 'package:edzesnaplo/screens/home/home_screen.dart';

import '../../l10n/app_localizations.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  String? _errorMessage;

  final AuthService _authService = AuthService();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = await _authService.signInWithEmail(_email, _password);
      if (result == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        setState(() => _errorMessage = result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.login)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              TextFormField(
                decoration: InputDecoration(labelText: loc.email),
                onSaved: (val) => _email = val!,
                validator: (val) =>
                val!.isEmpty ? loc.emailEmptyError : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: loc.password),
                obscureText: true,
                onSaved: (val) => _password = val!,
                validator: (val) =>
                (val == null || val.length < 6) ? loc.passwordShortError : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text(loc.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
