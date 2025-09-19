import 'package:flutter/material.dart';
import '../../../cores/services/auth_service.dart';
import 'package:edzesnaplo/screens/home/home_screen.dart';
import '../../l10n/app_localizations.dart';
import 'registration_screen.dart';

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
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        setState(() => _errorMessage = result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF071f35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF071f35),
        elevation: 0,
        title: Text(
          loc.login,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              _buildTextField(
                label: loc.email,
                onSaved: (val) => _email = val!.trim(),
                validator: (val) =>
                val == null || val.trim().isEmpty ? loc.emailEmptyError : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: loc.password,
                obscureText: true,
                onSaved: (val) => _password = val!.trim(),
                validator: (val) =>
                val == null || val.length < 6 ? loc.passwordShortError : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submit,
                child: Text(
                  loc.login,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistrationScreen()),
                  );
                },
                child: Text(
                  loc.dontHaveAccount,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    required void Function(String?) onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
