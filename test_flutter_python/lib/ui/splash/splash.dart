import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/ui/_base/bloc_state.dart';
import 'package:test_flutter_python/ui/home/home_page.dart';
import 'package:test_flutter_python/ui/selectip/selectip.dart';
import 'package:test_flutter_python/ui/splash/splash_bloc.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends StateWithBloC<Splash, SplashBloC> {
  @override
  void initState() {
    super.initState();
        Future.delayed(Duration(milliseconds: 800), () {
          NavigationUtils.pushReplacement(context, SelectIpPage());
        });
   
    
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.gray_bar,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'res/images/tema.png',
              width: 200,
            ),
            SizedBox(
              height: 50,
            ),
            TXText('Tasks'),
            TXText('Test Application'),
            TXText('Emilia M Castillo Fernández'),
            TXText('Version 1.0.0'),
          ],
        ),
      ),
    );
  }
}
