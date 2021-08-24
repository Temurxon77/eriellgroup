import 'package:flutter/material.dart';
import 'package:eriellapp/src/models/DataRow.dart';

class DataTableCustom extends StatelessWidget {
  final List<RowData>? rows;

  const DataTableCustom({Key? key, @required this.rows}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      rowsPerPage: 4,
        header: Text("Valorant Agents"),
        columns: [
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Class")),
          DataColumn(label: Text("Ultimate")),
          DataColumn(label: Text("Weapon"))
        ], source: DataSource(context,rows ?? [])
    );
  }
}

class DataSource extends DataTableSource {
  final BuildContext context;
  List<RowData> _rows = [];
  int _selectedCount = 0;


  DataSource(this.context,this._rows);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.name!)),
        DataCell(Text(row.classification!)),
        DataCell(Text(row.ultimate!)),
        DataCell(Text(row.weapon!)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => _selectedCount;

}