import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:garden_app/generated/l10n.dart';

class PulsingFloatingButton extends HookWidget {
  final bool pulseEnabled;
  final VoidCallback onTap;

  const PulsingFloatingButton({
    Key? key,
    required this.pulseEnabled,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController? controller;

    if (pulseEnabled) {
      controller = useAnimationController(
        duration: const Duration(seconds: 1),
        upperBound: 10,
      )..repeat(reverse: true);
    }

    return pulseEnabled
        ? AnimatedBuilder(
            animation: controller!,
            builder: (_, __) => _FloatingAddPlantButton(
              elevation: controller!.value,
              onTap: onTap,
            ),
          )
        : _FloatingAddPlantButton(
            elevation: 3,
            onTap: onTap,
          );
  }
}

class _FloatingAddPlantButton extends StatelessWidget {
  final double elevation;
  final VoidCallback onTap;

  const _FloatingAddPlantButton({
    Key? key,
    required this.elevation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: FloatingActionButton(
        isExtended: true,
        onPressed: onTap,
        elevation: elevation,
        child: Text(S.of(context).addPlant),
      ),
    );
  }
}
