import 'package:flutter/material.dart';

/// Divider com label simples para categorizar configurações
class SettingsTab extends StatelessWidget {
  final String label;
  const SettingsTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text(label)),
          Divider(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
