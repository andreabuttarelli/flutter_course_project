part of '../views/revolut_home.view.dart';

class _IndicatorItem extends StatelessWidget {
  const _IndicatorItem({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: enabled ? Colors.black : Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
