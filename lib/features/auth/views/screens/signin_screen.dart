import 'package:backlog_roulette/core/l10n/app_localizations.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.validators_the_fields_are_invalid,
          ),
        ),
      );
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
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.sign_in_screen_title,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 52),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: AppLocalizations.of(
                  context,
                )!.sign_in_screen_email_hinttext,
                textEditingController: emailController,
                icon: Icon(Icons.email),
                validator: (value) => Validators.validateEmail(
                  value,
                  AppLocalizations.of(context)!,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: AppLocalizations.of(
                  context,
                )!.sign_in_screen_password_hinttext,
                textEditingController: passwordController,
                icon: Icon(Icons.password),
                isPassword: true,
                validator: (value) => Validators.validatePassword(
                  value,
                  AppLocalizations.of(context)!,
                ),
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
                        AppLocalizations.of(
                          context,
                        )!.sign_in_screen_sign_in_button_label,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
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
                    text:
                        "${AppLocalizations.of(context)!.sign_in_screen_no_account_label} ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(
                          context,
                        )!.sign_up_screen_title,
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
