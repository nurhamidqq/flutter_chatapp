import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
          onPressed: () => ref.read(authRepositoryProvider).logout(),
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
