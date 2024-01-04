import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/chat_page.dart';
import 'package:flutter_chatapp/presentation/pages/home_page/home_page.dart';
import 'package:flutter_chatapp/presentation/pages/login_page.dart';
import 'package:flutter_chatapp/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/chat',
          name: 'chat',
          builder: (context, state) => ChatPage(state.extra as (User, User)),
        ),
      ],
      initialLocation: '/login',
      debugLogDiagnostics: false,
    );
