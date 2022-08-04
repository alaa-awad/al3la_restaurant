import 'package:al3la_restaurant/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: token!,
        size: MediaQuery.of(context).size.width *0.7,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
