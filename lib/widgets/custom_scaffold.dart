import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/image_assets.dart';
import '../utils/themes.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? body;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: .6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: 75,
            bottom: 75,
            right: 0,
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 23,
                    ),
                    SizedBox(width: 10),
                    Flexible(child: Text("John Doe"))
                  ],
                ),
                Column(
                  children: <Widget>[
                    DrawerListItem(
                      onTap: () {},
                      icon: Image.asset(
                        ImageAssets.homeIcon,
                        width: 24,
                      ),
                      title: "Home",
                    ),
                    DrawerListItem(
                      onTap: () {},
                      icon: Image.asset(
                        ImageAssets.galleryIcon,
                        width: 24,
                      ),
                      title: "Gallery",
                    ),
                    DrawerListItem(
                      onTap: () {},
                      icon: Image.asset(
                        ImageAssets.committeesIcon,
                        width: 22,
                      ),
                      title: "Committees & Events",
                    ),
                    DrawerListItem(
                      onTap: () {},
                      icon: Image.asset(
                        ImageAssets.callIcon,
                        width: 24,
                      ),
                      title: "Contact Us",
                    ),
                  ],
                ),
                DrawerListItem(
                  onTap: () {},
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    size: 24,
                    color: Color(0xFF22ABE5),
                  ),
                  title: "Log out",
                ),
              ],
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: _controller,
            builder: (context, value, child) {
              // If drawer is not open directly return scaffold
              if (value == 0.0) return child!;

              final borderRadius = BorderRadius.circular(30 * value);
              return Transform.translate(
                offset: Offset(-size.width / 2 * value, 0),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.lerp(
                          null,
                          Border.all(color: kDarkModeDarkBlue),
                          value,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3322ABE5),
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: Offset(3, 3),
                          )
                        ],
                        borderRadius: borderRadius,
                      ),
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Scaffold(
              appBar: widget.appBar,
              body: widget.body,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  if (_controller.isCompleted)
                    _controller.reverse();
                  else
                    _controller.forward();
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF136ABF),
                        Color(0xFF4391DE),
                      ],
                    ),
                  ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => Transform.rotate(
                      angle: math.pi * _controller.value,
                      child: _controller.value > .5
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            )
                          : CustomPaint(
                              painter: _MenuIconPainter(),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            icon,
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// This is generated using fluttershapemaker.com
class _MenuIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06666667
      ..color = const Color(0xffF2F5F8)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 0.06296800, size.height * 0.09358714),
        Offset(size.width * 0.5478167, size.height * 0.09358714), paint);

    canvas.drawLine(Offset(size.width * 0.06296800, size.height * 0.5221571),
        Offset(size.width * 0.9595000, size.height * 0.5221571), paint);

    canvas.drawLine(Offset(size.width * 0.06296800, size.height * 0.9507286),
        Offset(size.width * 0.6659967, size.height * 0.9507286), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
