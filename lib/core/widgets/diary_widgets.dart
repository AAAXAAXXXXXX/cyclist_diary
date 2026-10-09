import 'package:flutter/material.dart';

class DiaryButton extends StatelessWidget {
  const DiaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.secondary = false,
  });
  final String label;
  final VoidCallback onPressed;
  final bool secondary;
  @override
  Widget build(BuildContext context) => secondary
      ? OutlinedButton(onPressed: onPressed, child: Text(label))
      : FilledButton(onPressed: onPressed, child: Text(label));
}

class DiaryField extends StatefulWidget {
  const DiaryField({
    super.key,
    required this.label,
    required this.controller,
    this.password = false,
    this.email = false,
  });
  final String label;
  final TextEditingController controller;
  final bool password;
  final bool email;
  @override
  State<DiaryField> createState() => _DiaryFieldState();
}

class _DiaryFieldState extends State<DiaryField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: widget.controller,
      obscureText: widget.password && hidden,
      keyboardType: widget.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      autocorrect: !widget.password && !widget.email,
      enableSuggestions: !widget.password,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.password
            ? IconButton(
                tooltip: hidden ? 'Показати пароль' : 'Приховати пароль',
                onPressed: () => setState(() => hidden = !hidden),
                icon: Icon(
                  hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
    ),
  );
}

class DiaryCard extends StatelessWidget {
  const DiaryCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: Padding(padding: const EdgeInsets.all(24), child: child),
  );
}
