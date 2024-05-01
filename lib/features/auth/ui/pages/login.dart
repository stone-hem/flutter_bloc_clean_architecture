import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/common/widgets/loader.dart';
import 'package:flutter_bloc_clean_architecture/core/utils/show_snack.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/pages/register.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/widgets/auth_button.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/widgets/auth_form_field.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
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
                      'Welcome! Use your email and password to sign in',
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
                      hintText: 'password',
                      controller: passwordController,
                      isTextObscure: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthButton(
                      buttonText: 'Login',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthLoginEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim()));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, RegisterPage.route()),
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an Account?  ',
                            children: [
                              TextSpan(
                                  text: 'Register',
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
      ),
    );
  }
}
