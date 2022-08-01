import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '';

class DataTableWidget extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  final String localisation;
  final String instruction;
  final String civility;

  DataTableWidget({
    required this.name,
    required this.email,
    required this.contact,
    required this.localisation,
    required this.instruction,
    required this.civility,
  });
  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Pattern",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  " Description ",
                  style:
                      GoogleFonts.poppins(fontSize: 16, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Name"),
                    Text(widget.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Email"),
                    Text(widget.email),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Contact"),
                    Text(widget.contact),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Localisation"),
                    Text(widget.localisation)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Civility"),
                    Text(widget.civility),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(" Instruction"),
                    Text(widget.instruction)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*List<DataColumn> _createColumn() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Book')),
      DataColumn(label: Text('Author'))
    ];
  }

  List<DataRow> _createRow() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumn(), rows: _createRow());
  }*/
}
