import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class BuatQr extends StatefulWidget {
  BuatQr({Key key}) : super(key: key);

  @override
  _BuatQrState createState() => _BuatQrState();
}

class _BuatQrState extends State<BuatQr> {
  TextEditingController _controllerTextField = TextEditingController();
  GlobalKey _renderObjectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _renderObjectKey,
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            IsTitle(),
            IsWave(),
            Align(
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                height: 200,
                width: 200,
                child: QrImage(
                  // key: _renderObjectKey,
                  data: _controllerTextField.text,
                  version: 6,
                  backgroundColor: Colors.white,
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(bottom: 10),
                height: 100,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _controllerTextField,
                      onChanged: (value) {
                        print(_controllerTextField);
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        fillColor: Colors.white30,
                        filled: true,
                        labelText: 'Masukkan tulisan apa saja',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox.expand(
                        child: RaisedButton(
                          onPressed: () {
                            // _getWidgetImage(_renderObjectKey.currentContext);
                          },
                          child: Text('asas'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IsTitle extends StatelessWidget {
  const IsTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 90),
      child: Align(
        child: Text(
          'BUAT QR',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class IsWave extends StatelessWidget {
  const IsWave({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        height: 300,
        child: SvgPicture.asset(
          'assets/wave2.svg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

Future<Uint8List> _getWidgetImage(_renderObjectKey) async {
  print(_renderObjectKey);
  try {
    RenderRepaintBoundary boundary =
        _renderObjectKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);
    debugPrint(bs64.length.toString());
    return pngBytes;
  } catch (exception) {
    throw exception;
  }
}
