import 'package:flutter/material.dart';
import '../../../cores/services/auth_service.dart';
import '../../l10n/app_localizations.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _confirmPassword = '';
  String? _errorMessage;
  final AuthService _authService = AuthService();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_password != _confirmPassword) {
        setState(() {
          _errorMessage = AppLocalizations.of(context)!.passwordsDoNotMatch;
        });
        return;
      }

      final result = await _authService.registerWithEmail(_email, _password);
      if (result == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      } else {
        setState(() => _errorMessage = result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.register)),
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
                validator: (val) => (val == null || val.length < 6)
                    ? loc.passwordShortError
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: loc.confirmPassword),
                obscureText: true,
                onSaved: (val) => _confirmPassword = val!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text(loc.register),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                child: Text(loc.alreadyHaveAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
