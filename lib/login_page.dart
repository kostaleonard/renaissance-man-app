import 'package:flutter/material.dart';
import 'package:renaissance_man/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    _UsernameInput(),
                    const SizedBox(height: 12),
                    _PasswordInput(),
                    _LoginButton(onTap: () {
                      _login(context);
                    })
                  ],
                )))
      ],
    ));
  }

  void _login(BuildContext context) {
    Navigator.of(context).restorablePushNamed(homeRoute);
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(labelText: 'Username'),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LoginButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: const Row(
        children: [
          Icon(Icons.lock),
          SizedBox(
            width: 6,
          ),
          Text('Login')
        ],
      ),
    );
  }
}
