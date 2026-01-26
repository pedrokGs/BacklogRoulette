import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/core/themes/app_colors.dart';
import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/viewmodels/states/auth_state.dart';
import 'package:backlog_roulette/features/auth/views/utils/validators.dart';
import 'package:backlog_roulette/features/auth/views/widgets/auth_button.dart';
import 'package:backlog_roulette/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("The fields are invalid")));
      return;
    }
    await ref
        .read(authNotifierProvider.notifier)
        .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.accentError,
            ),
          );
        },
        authenticated: () {
          context.goNamed(RouteNames.home);
        },
        orElse: () {},
      );
    });

    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In.',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 52),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'Email',
                textEditingController: emailController,
                icon: Icon(Icons.email),
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: 'Password',
                textEditingController: passwordController,
                icon: Icon(Icons.password),
                isPassword: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 24),
              AuthButton(
                size: !isLoading ? Size(200, 52) : Size(390, 40),
                borderRadius: !isLoading ? 15 : 50,
                onTap: signIn,
                color: !isLoading
                    ? AppColors.primaryPurple
                    : AppColors.primaryDarkPurple,
                child: !isLoading
                    ? Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : LoadingAnimationWidget.progressiveDots(
                        color: AppColors.darkTextPrimary,
                        size: 30,
                      ),
              ),
              TextButton(
                onPressed: () => context.goNamed(RouteNames.signup),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextPrimary,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: "Sign Up.",
                        style: TextStyle(color: AppColors.primaryPurple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
