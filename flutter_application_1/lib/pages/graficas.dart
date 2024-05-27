import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficasPage extends StatelessWidget {
  const GraficasPage({super.key});
  static const String ROUTE = "/graficas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráficas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Conteo de tareas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _generateSections(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    int completadas = 7;
    int noCompletadas = 5;
    int eliminadas = 3;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: completadas.toDouble(),
        title: '$completadas',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: noCompletadas.toDouble(),
        title: '$noCompletadas',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: eliminadas.toDouble(),
        title: '$eliminadas',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}
