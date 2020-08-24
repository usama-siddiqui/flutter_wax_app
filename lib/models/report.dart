class Report {
  final int temp;
  final String wax, line, timeStamp;

  Report({this.temp, this.wax, this.line, this.timeStamp});

  Report.fromJson(Map<String, dynamic> json)
      : temp = json["temp"],
        wax = json["wax"],
        line = json["line"],
        timeStamp = json["timeStamp"];
}
