import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:readit/theme/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // TODO: check
  void handleLoad() async {
    Future.delayed(
      const Duration(seconds: 3),
      () => {context.pushNamed("home")},
    );
  }

  @override
  void initState() {
    super.initState();
    handleLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourGlass(color: AppColors.primaryColour),
      ),
    );
  }
}
