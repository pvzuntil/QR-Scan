import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart';
import 'package:scanner/BuatQr.dart';

import 'BottomSheetResult.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: Stack(
          children: <Widget>[
            IsBurung(),
            IsTitle(),
            IsWave(),
            RowButton(),
          ],
        ),
      ),
    );
  }
}

class RowButton extends StatelessWidget {
  const RowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 35),
          height: 50,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox.expand(
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'BUAT QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.downToUp,
                            child: BuatQr(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox.expand(
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'SCAN QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        bacaQR(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class IsBurung extends StatelessWidget {
  const IsBurung({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 100,
      width: 250,
      child: Align(
        alignment: Alignment.topLeft,
        child: SvgPicture.asset('assets/burung.svg'),
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
      margin: EdgeInsets.only(top: 150),
      child: Align(
        child: Text(
          'QR SCANner.',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
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
          'assets/wave.svg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

void bacaQR(context) async {
  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  if (permissions[PermissionGroup.camera] == PermissionStatus.granted) {
    String hasilScan = await scan();
    bool _validURL = Uri.parse(hasilScan).isAbsolute;
    print(_validURL);
    showBottomSheet(
      context: context,
      builder: (builder) {
        return BuildResultBottomSheet(hasilScan, _validURL);
      },
    );
  } else {
    showBottomSheet(
      elevation: 20,
      context: context,
      builder: (builder) {
        return Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Peringatan !',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                          'Fitur ini harus mempunyai akses ke kamera anda, silahkan coba lagi !')
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
