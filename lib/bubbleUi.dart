import 'package:algvisualizerprovider/bubbleLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BubbleSortVisualizer extends StatefulWidget {
  @override
  _BubbleSortVisualizerState createState() => _BubbleSortVisualizerState();
}

class _BubbleSortVisualizerState extends State<BubbleSortVisualizer> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BubbleLogic>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Sort Visualization'),
        actions: [
          IconButton(
            onPressed: provider.generateRandomList,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // to ignore overflow problem

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: provider.inputController,
                    decoration: const InputDecoration(
                      hintText: "Enter List of Numbers with Commas",
                      labelText: 'Enter numbers',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Number!!!!';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      provider.generateListFromInput(text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 400),
                painter: BubbleSortPainter(
                  numbers: provider.numbers,
                  comparingIndex: provider.comparingIndex,
                  swappingIndex: provider.swappingIndex,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: provider.numbers.isNotEmpty
                        ? provider.bubbleSort
                        : null,
                    child: const Text("Sorting"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BubbleSortPainter extends CustomPainter {
  final List<int> numbers;
  final int? comparingIndex;
  final int? swappingIndex;

  BubbleSortPainter({
    required this.numbers,
    this.comparingIndex,
    this.swappingIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final barWidth = size.width / numbers.length;

    for (int i = 0; i < numbers.length; i++) {
      final x = i * barWidth;
      final y = size.height - numbers[i].toDouble();
      paint.color =
          i == comparingIndex || i == swappingIndex ? Colors.red : Colors.blue;
      canvas.drawRect(Rect.fromLTWH(x, y, barWidth - 2, numbers[i].toDouble()),
          paint); //Left ,top,width,height

      final textStyle = TextStyle(color: Colors.black, fontSize: 14);
      final textSpan = TextSpan(text: numbers[i].toString(), style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: barWidth);
      textPainter.paint(canvas,
          Offset(x + (barWidth - textPainter.width) / 2, size.height - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
