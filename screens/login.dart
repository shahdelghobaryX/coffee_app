import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import 'main_shell.dart';
import 'register.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signIn() {
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
            Text('Welcome to Login',
                style: poppins(24, weight: FontWeight.w600)),
            const SizedBox(height: 32),
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
            const SizedBox(height: 32),
            PrimaryButton(label: 'Sign in', onPressed: _signIn),
            const Spacer(flex: 2),
            const SocialButtons(),
            const Spacer(flex: 3),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Don't have an account ? ",
                        style: poppins(13, weight: FontWeight.w500)),
                    Text('Register',
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
