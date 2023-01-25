import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ---------------------------------------------------------------
// Date: 2023-01-12, SangwonKim
// Desc: 차트그리기 Class
class LineChartWidget extends StatefulWidget {
  final String id; // 유저 아이디 선언
  final List listChart; // 유저 진단 결과 리스트 선언 ***
  final String title;

  const LineChartWidget(
      {super.key,
      required this.id,
      required this.listChart,
      required this.title});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false; // 평균보여주기 유무

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.00,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Theme.of(context).primaryColorLight),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 36,
                    bottom: 20,
                  ),
                  child: LineChart(
                    showAvg
                        ? avgData(widget.listChart) // 유저 평균
                        : mainData(widget.listChart), // 유저 날짜별 위험도 기록
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              '평균',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                backgroundColor: Colors.white,
                color: showAvg
                    ? Colors.deepOrange.withOpacity(0.5)
                    : Colors.deepOrange,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Functions ---
  // -----------------------------------------------------------
  // Date: 2023-01-12, SangwonKim
  // Desc: 하단 텍스트
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      // fontWeight: FontWeight.bold,
      fontSize: 12,
      letterSpacing: -1,
    );
    // 위젯 텍스트 선언
    Widget text = const Text('');

    // Date: 2023-01-13, SangwonKim
    // Desc: 날짜 가져오기
    for (int i = 0; i < widget.listChart.length; i++) {
      if (value.toInt() == i) {
        text = Text(
          // orderby date로 가져올때 사용 ***
          widget.listChart[widget.listChart.length - i - 1]['dateValue']
              .toString()
              .replaceFirst('-', '\n'),

          style: style,
        );
      }
    }

    // --- 기존 방식 ---
    // switch (value.toInt()) {
    //   case 2:
    //     text = const Text('22.12.12', style: style);
    //     break;
    //   case 5:
    //     text = const Text('JUN', style: style);
    //     break;
    //   case 8:
    //     text = const Text('SEP', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    //     break;
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  // ---------------------------------------------------------
  // Date: 2023-01-12, SangwonKim
  // Desc: Y축 요소 설정하기 -> 0 ~ 100 설정
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  // -----------------------------------------------------------
  // Desc: 메인 차트
  LineChartData mainData(List listChart) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // X축 min, max
      minX: 0,
      maxX: 9,
      // Y축 min, max
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          // ******* (x,y)의 좌표 설정하기 *******
          spots: [
            for (int i = 0; i < listChart.length; i++) ...[
              FlSpot(
                  i.toDouble(),
                  // orderby date로 가져올때 사용하기 ***
                  double.parse(double.parse(listChart[listChart.length - i - 1]
                              ['resultValue']
                          .toString())
                      .toStringAsFixed(2))),
            ],
            // FlSpot(3, 3),
          ],
          // isCurved: true, // 커브주기
          // gradient: LinearGradient(colors: gradientColors),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ), // 점 보여주기
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2)) // 그래프 아래 투명도
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // Date: 2023-01-13, SangwonKim
  // Desc: 평균 차트
  LineChartData avgData(List listChart) {
    // Date: 2023-01-13, SangwonKim
    // Desc: 평균 구하기
    double sumResult = 0;
    double avgResult = 0;
    for (int i = 0; i < listChart.length; i++) {
      sumResult =
          sumResult + (double.parse(listChart[i]['resultValue'].toString()));
    }
    avgResult = sumResult / listChart.length;

    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 10,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < listChart.length; i++) ...[
              FlSpot(i.toDouble(), avgResult),
            ],
            // FlSpot(0, 3.44),
            // FlSpot(2.6, 3.44),
            // FlSpot(4.9, 3.44),
            // FlSpot(6.8, 3.44),
            // FlSpot(8, 3.44),
            // FlSpot(9.5, 3.44),
            // FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.2),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
