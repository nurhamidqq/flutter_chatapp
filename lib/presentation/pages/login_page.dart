import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/extentions/build_context_extention.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:flutter_chatapp/presentation/providers/router/router_provider.dart';
import 'package:flutter_chatapp/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter_chatapp/presentation/widgets/my_button.dart';
import 'package:flutter_chatapp/presentation/widgets/my_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCtr = TextEditingController();
    final passwordCtr = TextEditingController();
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('home');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              verticalSpace(50),
              Icon(
                Icons.message,
                size: 80,
                color: Colors.grey[800],
              ),
              const Text(
                "Welcome back you've been missed!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(50),
              MyTextField(
                controller: emailCtr,
                hintText: 'Email',
                obsecureText: false,
              ),
              verticalSpace(20),
              MyTextField(
                controller: passwordCtr,
                hintText: 'Password',
                obsecureText: true,
              ),
              verticalSpace(20),
              SizedBox(
                height: 50,
                child: MyButton(
                  text: switch (ref.watch(userDataProvider)) {
                    AsyncData(:final value) =>
                      value == null ? 'SIGN IN' : 'Loading...',
                    _ => 'Loading...',
                  },
                  onTap: () {
                    if (emailCtr.text.isNotEmpty &&
                        passwordCtr.text.isNotEmpty) {
                      ref.read(userDataProvider.notifier).login(
                          email: emailCtr.text, password: passwordCtr.text);
                    } else {
                      context.showSnackBar('Please fill required fields');
                    }
                  },
                ),
              ),
              verticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member? '),
                  GestureDetector(
                    onTap: () => ref.read(routerProvider).pushNamed('register'),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
