import 'package:backlog_roulette/di/notifiers.dart';
import 'package:backlog_roulette/themes/flavors/grape_flavor.dart'; // Assumindo que Acai é Grape/Roxo
import 'package:backlog_roulette/themes/flavors/mint_flavor.dart';
import 'package:backlog_roulette/themes/flavors/orange_flavor.dart';
import 'package:backlog_roulette/themes/flavors/strawberry_flavor.dart';
import 'package:backlog_roulette/themes/theme_controller.dart';
import 'package:backlog_roulette/themes/theme_flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final controller = ref.read(themeProvider.notifier);
    final isDark = themeState.mode == ThemeMode.dark;

    final List<ThemeFlavor> flavors = [
      AcaiFlavor(),
      MintFlavor(),
      OrangeFlavor(),
      StrawberryFlavor(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, themeState.flavor.name),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, "Aparência"),
                  const SizedBox(height: 15),

                  _buildModeSwitchCard(context, controller, isDark),

                  const SizedBox(height: 35),
                  _buildSectionTitle(context, "Escolha seu Estilo"),
                  const SizedBox(height: 15),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.4,
                        ),
                    itemCount: flavors.length,
                    itemBuilder: (context, index) {
                      final flavor = flavors[index];
                      final isSelected =
                          flavor.runtimeType == themeState.flavor.runtimeType;
                      return _buildFlavorCard(
                        context,
                        flavor,
                        isSelected,
                        () => controller.changeFlavor(flavor),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, String currentFlavorName) {
    return SliverAppBar.large(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        "Configurações",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildModeSwitchCard(
    BuildContext context,
    ThemeController controller,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? Colors.indigo.shade900 : Colors.orange.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
            color: isDark ? Colors.indigo.shade100 : Colors.orange,
          ),
        ),
        title: const Text(
          "Modo Escuro",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(isDark ? "Ativado" : "Desativado"),
        trailing: Switch.adaptive(
          value: isDark,
          onChanged: (_) => controller.toggleThemeMode(),
          activeThumbColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildFlavorCard(
    BuildContext context,
    ThemeFlavor flavor,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final Color flavorColor = _getDemoColorForFlavor(flavor);

    final shadowColor = isSelected
        ? flavorColor.withValues(alpha: 0.7)
        : Colors.transparent;
    final double shadowBlur = isSelected ? 15.0 : 0.0;
    final Offset shadowOffset = isSelected ? const Offset(0, 8) : Offset.zero;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? flavorColor
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? flavorColor.withValues(alpha: 0.5)
                : Colors.transparent,
            width: isSelected ? 0 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlur,
              offset: shadowOffset,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: ClipRRect(
                child: Icon(
                  Icons.circle,
                  size: 100,
                  color: Colors.white.withValues(alpha: isSelected ? 0.2 : 0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.3)
                          : flavorColor,
                      shape: BoxShape.circle,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                  ),
                  Text(
                    flavor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDemoColorForFlavor(ThemeFlavor flavor) {
    if (flavor is AcaiFlavor) return Colors.purple;
    if (flavor is MintFlavor) return Colors.teal;
    if (flavor is OrangeFlavor) return Colors.orange;
    if (flavor is StrawberryFlavor) return Colors.redAccent;
    return Colors.grey;
  }
}
