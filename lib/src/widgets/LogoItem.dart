import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoItem extends StatelessWidget {
  final double? height;
  final double? width;

  const LogoItem({Key? key, this.height,this.width}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      width: this.width,
      child: Center(
          child: SvgPicture.asset("assets/images/logo.svg",height: this.height!*0.5,width: this.width!*0.5)
      )
    );
  }
}