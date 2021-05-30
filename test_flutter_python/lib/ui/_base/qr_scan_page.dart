/* import 'dart:io';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Map<String, String> resultParsed;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black_dark,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(flex: 4, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: resultParsed == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () async {
                                  await controller?.toggleFlash();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return snapshot.data
                                        ? Icon(
                                            CupertinoIcons.bolt_slash,
                                            color: AppColor.blue,
                                            size: 30,
                                          )
                                        : Icon(
                                            CupertinoIcons.bolt,
                                            color: AppColor.blue,
                                            size: 30,
                                          );
                                  },
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: InkWell(
                                onTap: () async {
                                  await controller?.flipCamera();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: controller?.getCameraInfo(),
                                  initialData: null,
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Icon(
                                        CupertinoIcons.camera_rotate,
                                        color: AppColor.blue,
                                        size: 30,
                                      );
                                    } else {
                                      return Text('Iniciando...');
                                    }
                                  },
                                )),
                          )
                        ],
                      )
                    : Container(
                        color: AppColor.black_dark,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              NavigationUtils.pop(context,
                                  result: resultParsed);
                            },
                            child: Icon(
                              Icons.check_circle_outline,
                              color: AppColor.green,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 120.0
        : 200.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColor.blue_alternative,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      resultParsed = _parseResult();
      setState(() {});
    });
  }

  Map<String, String> _parseResult() {
    try {
      String ci;
      String name;
      String lastName;
      bool containCI = result.code.contains('CI:');
      bool containName = result.code.contains('N:');
      bool containLastName = result.code.contains('A:');
      bool containFV = result.code.contains('FV:');
      if (containLastName && containName && containCI && containFV) {
        var valueToParse = result.code.replaceAll('\r\n', '');
        var one = valueToParse.split('FV:');
        var two = one[0].split('CI:');
        ci = two[1];
        var three = two[0].split('A:');
        lastName = three[1];
        name = three[0].substring(2, three[0].length);
        return {'name': name, 'ci': ci, 'lastName': lastName};
      } else
        return null;
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
 
 */
