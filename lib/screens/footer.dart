import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.mainColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Condiciones del servicio',
              style: Style.footerTitle,
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: 0.0),
              child: Text(
                'Aquí puede ir la política de devoluciones, etc. Suspendisse potenti. Nullam imperdiet laoreet blandit. Nulla consequat ante lacus, in ultrices nisl laoreet at. Donec pharetra fringilla mollis. Vivamus mi risus, venenatis a quam at, laoreet posuere lorem. Cras vitae tristique est. Mauris eu lobortis dolor. Ut sagittis ullamcorper magna sed tristique. Maecenas feugiat enim dolor, vel vestibulum diam consectetur quis. Vivamus eget vulputate leo, a finibus massa. ',
                style: Style.footerBody,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
