import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/core/themes/app_colors.dart';
import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/models/models/app_user.dart';
import 'package:backlog_roulette/features/auth/views/utils/validators.dart';
import 'package:backlog_roulette/features/auth/views/widgets/auth_button.dart';
import 'package:backlog_roulette/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("The fields are invalid")));
      return;
    }
    await ref
        .read(authNotifierProvider.notifier)
        .signUpWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);

    ref.listen<AsyncValue<AppUser?>>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 52),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'Username',
                textEditingController: usernameController,
                icon: Icon(Icons.person),
                validator: Validators.validateUsername,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: 'Confirm your Password',
                textEditingController: confirmPasswordController,
                icon: Icon(Icons.password),
                isPassword: true,
                validator: (value) {
                  if (passwordController.text != value) {
                    return "The passwords don't match!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AuthButton(
                size: !isLoading ? Size(200, 52) : Size(390, 40),
                borderRadius: !isLoading ? 15 : 50,
                onTap: signUp,
                color: !isLoading
                    ? AppColors.primaryPurple
                    : AppColors.primaryDarkPurple,
                child: !isLoading
                    ? Text(
                        "Sign up",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : LoadingAnimationWidget.progressiveDots(
                        color: AppColors.darkTextPrimary,
                        size: 30,
                      ),
              ),
              TextButton(
                onPressed: () => context.goNamed(RouteNames.signin),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextPrimary,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: "Sign In.",
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
