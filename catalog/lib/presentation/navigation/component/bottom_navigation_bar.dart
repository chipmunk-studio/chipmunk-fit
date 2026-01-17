import 'package:chip_foundation/colors.dart';
import 'package:chip_assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class FitBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const FitBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<FitBottomNavigationBar> createState() => _FitBottomNavigationBarState();
}

class _FitBottomNavigationBarState extends State<FitBottomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.05).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.05, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 10,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FitBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.fitColors.grey0,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: _buildNavigationItem(),
        ),
      ),
    );
  }

  Widget _buildNavigationItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildNavItem(
          icon: Icon(
            Icons.grid_on,
            size: 28,
            color: widget.selectedIndex == 0 ? context.fitColors.main : const Color(0xFFD7D8D9),
          ),
          index: 0,
        ),
        _buildNavItem(
          icon: Icon(
            Icons.widgets,
            size: 28,
            color: widget.selectedIndex == 1 ? context.fitColors.main : const Color(0xFFD7D8D9),
          ),
          index: 1,
        ),
        _buildNavItem(
          icon: Icon(
            Icons.view_module,
            size: 28,
            color: widget.selectedIndex == 2 ? context.fitColors.main : const Color(0xFFD7D8D9),
          ),
          index: 2,
        ),
        _buildNavItem(
          icon: Icon(
            Icons.build_circle,
            size: 28,
            color: widget.selectedIndex == 3 ? context.fitColors.main : const Color(0xFFD7D8D9),
          ),
          index: 3,
        ),
      ],
    );
  }

  Widget _buildNavItem({required Widget icon, required int index}) {
    return Expanded(
      child: Bounceable(
        onTap: () => widget.onItemTapped(index),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.selectedIndex == index)
                ScaleTransition(
                  scale: _animation,
                  child: icon,
                )
              else
                icon,
              const SizedBox(height: 4),
              Text(
                _getLabel(index),
                style: TextStyle(
                  color: widget.selectedIndex == index ? context.fitColors.main : const Color(0xFFD7D8D9),
                  fontSize: 11,
                  fontWeight: widget.selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: ChipAssets.fonts.pretendardRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Foundation';
      case 1:
        return 'Component';
      case 2:
        return 'Module';
      case 3:
        return 'Core';
      default:
        return '';
    }
  }
}
