//Routes
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const String kSplashPage = "/splash";
const String kLoginPage = "/login";
const String kSignUpPage = "/signup";
const String kAdminPage = "/admin";

//Colors
const Color materialColor = Color(0xFF0B529A);
final List<charts.Color> pieColors = [
  charts.MaterialPalette.red.shadeDefault,
  charts.MaterialPalette.blue.shadeDefault,
  charts.MaterialPalette.green.shadeDefault,
  charts.MaterialPalette.deepOrange.shadeDefault,
  charts.MaterialPalette.indigo.shadeDefault,
  charts.MaterialPalette.purple.shadeDefault,
  charts.MaterialPalette.lime.shadeDefault
];