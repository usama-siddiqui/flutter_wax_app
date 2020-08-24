import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wax_app/models/report.dart';
import 'package:wax_app/providers/settings_provider.dart';
import 'package:wax_app/screens/settings.dart';
import 'package:wax_app/services/firestore_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsProvider _settings = Provider.of<SettingsProvider>(context);
    var reports = Provider.of<List<Report>>(context)
        .where((report) => _settings.waxLines.contains(report.line))
        .toList();
    final FirestoreService _db = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wax App"),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Settings();
                }));
              })
        ],
      ),
      body: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, position) {
            return ListTile(
              leading: (_settings.units == "Metric")
                  ? Text(reports[position].temp.toString() + "\u00B0")
                  : Text(
                      (((reports[position].temp) * (9 / 5)) + 32).toString() +
                          "\u00B0"),
              title: Text(reports[position].wax),
              subtitle: Text(reports[position].line),
              trailing: Text(formatDate(
                  DateTime.parse(reports[position].timeStamp),
                  [h, ":", nn, " ", am])),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _db.addReport();
          }),
    );
  }
}
