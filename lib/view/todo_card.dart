import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TODOCard extends StatelessWidget {

  String title = "";
  double percentage = 0.0;
  int task = 0;

  TODOCard(
      {Key? key,
      String title = "",
      double percentage = 0.0,
      task = 12})
      : super(key: key) {
    this.title = title;
    this.percentage = percentage;
    this.task = task;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 8),
            child: Text(
              "$task Tasks",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 24),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 24),
            child: LinearPercentIndicator(
              animateFromLastPercent: true,
              width: MediaQuery.of(context).size.width * 0.5,
              animation: true,
              animationDuration: 1000,
              lineHeight: 4.0,
              trailing: new Text("${(percentage * 100).toStringAsFixed(0)}%"),
              percent: percentage,
              barRadius: const Radius.circular(2),
              progressColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
