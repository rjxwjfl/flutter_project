import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedCard extends ConsumerStatefulWidget {
  const AnimatedCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends ConsumerState<AnimatedCard>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _arrowRotateAnimation;
  late final Animation<double> _tileFadeAnimation;
  final Duration duration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    ref.read(theme);
    _animationController = AnimationController(vsync: this, duration: duration);
    _arrowRotateAnimation =
        Tween<double>(begin: 0, end: 0.5).animate(_animationController);
    _tileFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
      child: AnimatedContainer(
        duration: duration,
        height: _isExpanded ? 150 : 50,
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    "테마 색상 설정",
                    style: TextStyle(fontSize: 15),
                  )),
                  RotationTransition(
                    turns: _arrowRotateAnimation,
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  )
                ],
              ),
              AnimatedCrossFade(
                  firstChild: const SizedBox(),
                  secondChild: FadeTransition(
                    opacity: _tileFadeAnimation,
                    child: themeSelector(),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: duration)
            ],
          ),
        ),
      ),
    );
  }

  Widget themeSelector() {
    return Row(
      children: [
        themeImplement(1),
        themeImplement(2),
        themeImplement(3),
        themeImplement(4),
        themeImplement(5),
        themeImplement(6),
        themeImplement(7),
      ],
    );
  }

  Widget themeImplement(int code) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ref.watch(theme).schemeSelector(code);
            },
            child: Container(
              height: 60,
              width: 30,
              color: switcher(code),
            ),
          )
        ],
      ),
    );
  }

  Color switcher(code) {
    switch (code) {
      case 1:
        return const Color(0xFFae0d13);
      case 2:
        return const Color(0xFFff8e06);
      case 3:
        return const Color(0xFFffff99);
      case 4:
        return const Color(0xFF8a9a5b);
      case 5:
        return const Color(0xFF3964C3);
      case 6:
        return const Color(0xFF00030f);
      case 7:
        return const Color(0xFF0a0013);

      default:
        return const Color(0xFFFFFFFF);
    }
  }
}
