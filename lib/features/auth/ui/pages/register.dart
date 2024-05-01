import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/common/widgets/loader.dart';
import 'package:flutter_bloc_clean_architecture/core/utils/show_snack.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/pages/login.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/widgets/auth_button.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/widgets/auth_form_field.dart';

class RegisterPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const RegisterPage());

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
             showSnackBar(context: context, msg: state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Welcome! Use your email username and password to sign up',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthFormField(
                    hintText: 'email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthFormField(
                    hintText: 'username',
                    controller: usernameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthFormField(
                    hintText: 'password',
                    controller: passwordController,
                    isTextObscure: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthButton(
                    buttonText: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthRegisterEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              username: usernameController.text.trim(),
                            ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, LoginPage.route()),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an Account?  ',
                          children: [
                            TextSpan(
                                text: 'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
