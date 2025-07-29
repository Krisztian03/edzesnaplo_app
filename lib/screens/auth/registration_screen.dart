import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../../cores/services/auth_service.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '', _email = '', _password = '', _confirmPassword = '';
  String? _errorMessage;
  final AuthService _authService = AuthService();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_password != _confirmPassword) {
        setState(() {
          _errorMessage = AppLocalizations.of(context)!.passwordsDoNotMatch;
        });
        return;
      }

      final result = await _authService.registerWithEmail(_email, _password, _firstName);
      if (result == null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
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
          loc.register,
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
                label: loc.firstName,
                keyboardType: TextInputType.name,
                onSaved: (val) => _firstName = val!.trim(),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return loc.firstNameEmptyError;
                  }
                  final nameRegExp = RegExp(r"^[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ\s'-]+$");
                  if (!nameRegExp.hasMatch(val.trim())) {
                    return loc.firstNameInvalidError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: loc.email,
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => _email = val!.trim(),
                validator: (val) => val == null || val.trim().isEmpty
                    ? loc.emailEmptyError
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: loc.password,
                obscureText: true,
                onSaved: (val) => _password = val!.trim(),
                validator: (val) => val == null || val.length < 6
                    ? loc.passwordShortError
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: loc.confirmPassword,
                obscureText: true,
                onSaved: (val) => _confirmPassword = val!.trim(),
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
                  loc.register,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  loc.alreadyHaveAccount,
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
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
