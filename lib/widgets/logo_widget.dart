import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool showShadow;
  final Color? backgroundColor;
  final String? assetPath;

  const LogoWidget({
    super.key,
    this.size = 60,
    this.showShadow = true,
    this.backgroundColor,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF8B4513),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: assetPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Image.asset(
                assetPath!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultLogo();
                },
              ),
            )
          : _buildDefaultLogo(),
    );
  }

  Widget _buildDefaultLogo() {
    return Icon(
      Icons.local_cafe,
      size: size * 0.6,
      color: Colors.white,
    );
  }
}

class AnimatedLogoWidget extends StatefulWidget {
  final double size;
  final bool showShadow;
  final Color? backgroundColor;
  final String? assetPath;
  final Duration animationDuration;

  const AnimatedLogoWidget({
    super.key,
    this.size = 60,
    this.showShadow = true,
    this.backgroundColor,
    this.assetPath,
    this.animationDuration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedLogoWidget> createState() => _AnimatedLogoWidgetState();
}

class _AnimatedLogoWidgetState extends State<AnimatedLogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 0.5,
            child: LogoWidget(
              size: widget.size,
              showShadow: widget.showShadow,
              backgroundColor: widget.backgroundColor,
              assetPath: widget.assetPath,
            ),
          ),
        );
      },
    );
  }
}