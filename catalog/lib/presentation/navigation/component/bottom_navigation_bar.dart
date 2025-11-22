import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class FitBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final dartz.Function1<int, void> onItemTapped;

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
    return SizedBox(
      height: 96,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 96,
              child: widget.selectedIndex == 2
                  ? ChipAssets.images.bgBottomNavSelected.svg(
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      color: context.fitColors.grey0,
                    )
                  : ChipAssets.images.bgBottomNavUnselected.svg(
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      color: context.fitColors.grey0,
                    ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildNavigationItem(),
          ),
        ],
      ),
    );
  }

  _buildNavigationItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildNavItem(
          icon: ChipAssets.icons.icCatSelected.svg(
            width: 28,
            height: 28,
            color: widget.selectedIndex == 0 ? context.fitColors.main : Color(0xFFD7D8D9),
          ),
          index: 0,
        ),
        _buildNavItem(
          icon: ChipAssets.icons.icGiftSoild24.svg(
            width: 28,
            height: 28,
            color: widget.selectedIndex == 1 ? context.fitColors.main : Color(0xFFD7D8D9),
          ),
          index: 1,
        ),
        _buildNavItem(
          icon: ChipAssets.icons.icHome.svg(
            width: 28,
            height: 28,
            color: widget.selectedIndex == 2 ? context.fitColors.main : Color(0xFFD7D8D9),
          ),
          index: 2,
        ),
        _buildNavItem(
          icon: ChipAssets.icons.icFeedSoild24.svg(
            width: 28,
            height: 28,
            color: widget.selectedIndex == 3 ? context.fitColors.main : Color(0xFFD7D8D9),
          ),
          index: 3,
        ),
        _buildNavItem(
          icon: ChipAssets.icons.icProfileDefaultDark.svg(
            width: 28,
            height: 28,
            color: widget.selectedIndex == 4 ? context.fitColors.main : Color(0xFFD7D8D9),
          ),
          index: 4,
        ),
      ],
    );
  }

  Widget _buildNavItem({required SvgPicture icon, required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onItemTapped(index),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 28),
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
                  color: widget.selectedIndex == index ? context.fitColors.main : Color(0xFFD7D8D9),
                  fontSize: 13,
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
        return 'foundation';
      case 1:
        return 'component';
      case 2:
        return 'module';
      case 3:
        return 'template';
      case 4:
        return 'develop';
      default:
        return '';
    }
  }
}
