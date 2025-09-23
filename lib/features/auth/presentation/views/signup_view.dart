import 'package:flutter/material.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: SignupBody()));
  }
}
