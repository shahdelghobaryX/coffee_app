import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import 'main_shell.dart';
import '../theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Spacer(flex: 3),
            Text('Register your Account',
                style: poppins(24, weight: FontWeight.w600)),
            const SizedBox(height: 28),
            AuthField(
              hint: 'Full Name',
              controller: _name,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
            ),
            const SizedBox(height: 8),
            AuthField(
              hint: 'E-mail Address',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  (v == null || !v.contains('@')) ? 'Enter a valid e-mail' : null,
            ),
            const SizedBox(height: 8),
            AuthField(
              hint: 'Password',
              controller: _password,
              obscure: true,
              validator: (v) =>
                  (v == null || v.length < 6) ? 'At least 6 characters' : null,
            ),
            const SizedBox(height: 8),
            AuthField(
              hint: 'Confirm Password',
              controller: _confirm,
              obscure: true,
              validator: (v) =>
                  v != _password.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Register', onPressed: _register),
            const Spacer(flex: 2),
            const SocialButtons(),
            const Spacer(flex: 2),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Already have an account ? ',
                        style: poppins(13, weight: FontWeight.w500)),
                    Text('Sign in',
                        style: poppins(13,
                            weight: FontWeight.w500, color: AppColors.card)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
