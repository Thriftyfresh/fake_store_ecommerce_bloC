import 'package:fake_store/presentation/widgets/app_theme.dart';
import 'package:fake_store/core/widgets/theme_notifier.dart';
import 'package:fake_store/data/datasources/api_service.dart';
import 'package:provider/provider.dart';
import 'package:fake_store/data/repositories/auth_repository.dart';
import 'package:fake_store/data/repositories/cart_repository.dart';
import 'package:fake_store/data/repositories/product_repository_impl.dart';
import 'package:fake_store/data/repositories/user_repository.dart';
import 'package:fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:fake_store/presentation/blocs/cart/cart_bloc.dart';
import 'package:fake_store/presentation/blocs/product/product_bloc.dart';
import 'package:fake_store/presentation/blocs/search/search_bloc.dart';
import 'package:fake_store/presentation/blocs/user/user_bloc.dart';
import 'package:fake_store/presentation/pages/auth_wrapper.dart';
import 'package:fake_store/presentation/pages/login_page.dart';
import 'package:fake_store/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (_) => ApiService()),
              RepositoryProvider(create: (_) => const FlutterSecureStorage()),
              RepositoryProvider(
                create: (context) => AuthRepository(
                  context.read<ApiService>(),
                  context.read<FlutterSecureStorage>(),
                ),
              ),
              RepositoryProvider(
                create: (context) =>
                    ProductRepository(context.read<ApiService>()),
              ),
              RepositoryProvider(
                create: (context) => CartRepository(
                  context.read<ApiService>(),
                  context.read<ProductRepository>(),
                ),
              ),
              RepositoryProvider(
                create: (context) => UserRepository(context.read<ApiService>()),
              ),
            ],
            child: Builder(
              // Add this Builder widget
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          AuthBloc(context.read<AuthRepository>()),
                    ),
                    BlocProvider(
                      create: (context) =>
                          ProductBloc(context.read<ProductRepository>()),
                    ),
                    BlocProvider(
                      create: (context) =>
                          CartBloc(context.read<CartRepository>()),
                    ),
                    BlocProvider(
                      create: (context) => SearchBloc(
                        context.read<ProductRepository>(),
                      ), // Fixed context
                    ),
                    BlocProvider(
                      create: (context) =>
                          UserBloc(context.read<UserRepository>()),
                      lazy: true,
                    ),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Fake Store',
                    theme: AppTheme.lightTheme,
                    themeMode: themeNotifier.themeMode,
                    home: const AuthWrapper(),
                    routes: {
                      '/login': (context) => LoginPage(),
                      '/products': (context) => const ProductListPage(),
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
