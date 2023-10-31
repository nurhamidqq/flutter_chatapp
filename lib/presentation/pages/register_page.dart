import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/extentions/build_context_extention.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:flutter_chatapp/presentation/providers/router/router_provider.dart';
import 'package:flutter_chatapp/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter_chatapp/presentation/widgets/my_button.dart';
import 'package:flutter_chatapp/presentation/widgets/my_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtr = TextEditingController();
    final emailCtr = TextEditingController();
    final passwordCtr = TextEditingController();
    final confirmPasswordCtr = TextEditingController();

    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed('home');
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
                "Let's create an account for you!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(50),
              MyTextField(
                controller: nameCtr,
                hintText: 'Name',
                obsecureText: false,
              ),
              verticalSpace(20),
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
              MyTextField(
                controller: confirmPasswordCtr,
                hintText: 'Confirm Password',
                obsecureText: true,
              ),
              verticalSpace(20),
              SizedBox(
                height: 50,
                child: MyButton(
                  text: switch (ref.watch(userDataProvider)) {
                    AsyncData(:final value) =>
                      value == null ? 'SIGN UP' : 'Loading...',
                    _ => 'Loading...',
                  },
                  onTap: () {
                    if (nameCtr.text.isNotEmpty && emailCtr.text.isNotEmpty) {
                      if (passwordCtr.text == confirmPasswordCtr.text) {
                        ref.read(userDataProvider.notifier).register(
                            email: emailCtr.text,
                            password: passwordCtr.text,
                            name: nameCtr.text);
                      } else {
                        context.showSnackBar(
                            'Please retype your password with the same value');
                      }
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
                  const Text('Already a member? '),
                  GestureDetector(
                    onTap: () => ref.watch(routerProvider).pop(),
                    child: const Text(
                      'Login Now',
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
