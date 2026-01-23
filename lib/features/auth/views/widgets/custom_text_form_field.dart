import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? Function(String? value)? validator;
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPassword;
  final Widget? icon;
  const CustomTextFormField({
    super.key,
    this.validator,
    required this.hintText,
    required this.textEditingController,
    this.isPassword = false,
    this.icon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.textEditingController,
      obscureText: isObscure,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
    );
  }
}
