import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildResultBottomSheet extends StatelessWidget {
  final String hasil;
  final bool isUrl;
  BuildResultBottomSheet(this.hasil, this.isUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/1.svg',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/2.svg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/3.svg',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              'assets/4.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 150,
            // left: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hasil Barcode',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    (isUrl) ? 'Link URL' : 'Plaintext',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 450,
                    child: ListView(
                      children: <Widget>[SelectableText(this.hasil)],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 30,
                bottom: 50,
                right: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    child: RaisedButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: this.hasil),
                        );
                        Toast.show(
                          "Berhasil disalin",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                        );
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        'SALIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: isUrl
                          ? () {
                              _launchURL(this.hasil);
                            }
                          : null,
                      child: Text(
                        'BUKA URL',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
