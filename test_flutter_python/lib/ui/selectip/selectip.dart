import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_python/di/injector.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_button.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_textfield.dart';
import 'package:test_flutter_python/ui/_base/bloc_state.dart';
import 'package:test_flutter_python/ui/home/home_page.dart';
import 'package:test_flutter_python/ui/selectip/selectip_bloc.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';

class SelectIpPage extends StatefulWidget {
  SelectIpPage();

  @override
  _SelectIpPageState createState() => _SelectIpPageState();
}

class _SelectIpPageState extends StateWithBloC<SelectIpPage, SelectIpdBloC> {
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc.validserverStream.listen((event) async {
      if (!event) {
        Fluttertoast.showToast(
          msg: 'Server not found',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        String serverDeveloperHost = 'http://${titleController.text}';
        NavigationUtils.pushReplacement(
            context, MyHomePage(serverDeveloperHost: serverDeveloperHost));
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TXText(
          'Django Api',
          color: AppColor.blue_alternative,
          fontSize: 20,
        ),
        backgroundColor: AppColor.gray_bar,
      ),
      body: Stack(
        children: [
          Card(
            color: AppColor.gray_light,
            margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 60),
              child: Column(
                children: <Widget>[
                  TXTextField(
                    label: 'IP and Port',
                    inputType: TextInputType.text,
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TXButton(
                      text: 'Save',
                      color: Colors.white,
                      onPressed: () {
                        bloc.validserver('http://${titleController.text}');
                      },
                    ),
                  ),
                  SizedBox(
              height: 50,
            ),
            TXText('Set IP_address:Port where is deploying'),
            TXText('the Django app'),
          
                ],
                
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.

      backgroundColor: Colors.white,
    );
  }
}
