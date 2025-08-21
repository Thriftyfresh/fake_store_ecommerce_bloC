import 'package:fake_store/data/repositories/auth_repository.dart';
import 'package:fake_store/presentation/pages/login_page.dart';
import 'package:fake_store/presentation/pages/product_list_page.dart';
import 'package:fake_store/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late Future<bool> _authCheck;

  @override
  void initState() {
    super.initState();
    _authCheck = context.read<AuthRepository>().isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authCheck,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        return snapshot.data == true ? const ProductListPage() : LoginPage();
      },
    );
  }
}
