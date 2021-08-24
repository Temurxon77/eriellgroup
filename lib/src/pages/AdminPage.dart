import 'dart:convert';

import 'package:eriellapp/src/models/DataRow.dart';
import 'package:eriellapp/src/utils/constants.dart';
import 'package:eriellapp/src/utils/helperFunctions.dart';
import 'package:eriellapp/src/widgets/CirclePaint.dart';
import 'package:eriellapp/src/widgets/DataTable.dart';
import 'package:eriellapp/src/widgets/PieChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  List<RowData> _rows = [];
  bool? isLandscape;

  @override
  void initState() {
    super.initState();
    readFromJSON();
    isLandscape = false;
  }

  void didChangeDependencies() {
    final orientation = MediaQuery.of(context).orientation;
    isLandscape = orientation != Orientation.landscape ? false : true;
    setState(() {});
    super.didChangeDependencies();
  }

  Future<void> readFromJSON() async {
    var jsonFile = await DefaultAssetBundle.of(context).loadString("assets/files/rows.json");
    final data = json.decode(jsonFile);
    for(var node in data){
      final info = RowData.fromJson(node);
      _rows.add(info);
    }
    setState(() {});
    print(_rows[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          //padding: const EdgeInsetsDirectional.only(start: 0),
          automaticallyImplyMiddle: false,
          automaticallyImplyLeading: false,
          middle: const Text("Admin Page"),
        ),
        child: ListView(
          //padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
          shrinkWrap: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
          addAutomaticKeepAlives: false,
          children: [
            isLandscape! ? const SizedBox() : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    height: 300.0,
                    child: SimplePieChart.withRandomData()
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     for(int i = 0; i<7;i++)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [ SizedBox(height: 24,width: 35,child: CustomPaint(painter: CirclePainter(pieColors[i].a,pieColors[i].r,pieColors[i].g,pieColors[i].b))),
                          Text("Product ${i+1}")
                        ])
                   ]
                  )
                )
              ]
            ),
            DataTableCustom(rows: _rows)
          ]
        )
        );
  }
}