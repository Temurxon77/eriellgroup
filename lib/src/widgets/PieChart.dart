import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eriellapp/src/utils/constants.dart';
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;
  final int maxData;

  SimplePieChart(this.seriesList,this.maxData, {this.animate = false});

  /// Creates a [PieChart] with sample data and no transition.
  factory SimplePieChart.withSampleData() {
    return new SimplePieChart(
      _createSampleData(),
      7,
      // Disable animations for image tests.
      animate: true
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SimplePieChart.withRandomData() {
    return new SimplePieChart(_createRandomData(7),7,animate: true);
  }

  /// Create random data.
  static List<charts.Series<LinearSales, int>> _createRandomData(int max) {
    final random = new Random();
    List<LinearSales> data = [];

    for(int i=0;i<max;i++){
      data.add(new LinearSales(i,random.nextInt(100),pieColors[i]));
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        labelAccessorFn: (LinearSales row,_) => "${row.sales}",
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100,charts.MaterialPalette.red.shadeDefault),
      new LinearSales(1, 75,charts.MaterialPalette.blue.shadeDefault),
      new LinearSales(2, 25,charts.MaterialPalette.green.shadeDefault),
      new LinearSales(3, 5,charts.MaterialPalette.deepOrange.shadeDefault),
      new LinearSales(4, 45,charts.MaterialPalette.indigo.shadeDefault),
      new LinearSales(5, 15,charts.MaterialPalette.purple.shadeDefault),
      new LinearSales(6, 12,charts.MaterialPalette.lime.shadeDefault),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        labelAccessorFn: (LinearSales row,_) => "${row.sales}",
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales,this.color);
}