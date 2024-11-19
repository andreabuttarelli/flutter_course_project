import 'package:flutter/material.dart';
import 'package:prova/src/presentation/design_system/progress_indicator/circular_progress_indicator.dart';
import 'package:prova/src/presentation/design_system/typography/widgets/typography.widget.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final bool enabled;
  final Future Function() onTap;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: MouseRegion(
        onEnter: (e) => {
          setState(() {
            _hovered = true;
          })
        },
        onExit: (e) => {
          setState(() {
            _hovered = false;
          })
        },
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              _hovered
                  ? colors.primary.withOpacity(widget.enabled ? 1 : 0.5)
                  : colors.secondary.withOpacity(widget.enabled ? 1 : 0.5),
            ),
            foregroundColor: WidgetStateProperty.all<Color>(
              _hovered
                  ? colors.primary.withOpacity(widget.enabled ? 1 : 0.5)
                  : colors.secondary.withOpacity(widget.enabled ? 1 : 0.5),
            ),
          ),
          onPressed: () async {
            setState(() {
              _loading = true;
            });
            await widget.onTap();
            setState(() {
              _loading = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _loading
                ? const Center(
                    child: CCircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : H2(
                    widget.label,
                    color: colors.primary.withOpacity(widget.enabled ? 1 : 0.5),
                  ),
          ),
        ),
      ),
    );
  }
}
