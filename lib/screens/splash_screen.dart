import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:readit/Theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void delay() async {
    await Future.delayed(
        const Duration(seconds: 2), () => {context.pushNamed("home")});
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/readit.png",
                width: size.width * 0.2,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SpinKitFadingCircle(
              color: AppColors.loaderColor,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
