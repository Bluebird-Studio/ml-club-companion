import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'main.dart' show PageBody, SectionTitle, navy, blue, teal;
import 'ml_math.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Column(children: [
      const TabBar(tabs: [
        Tab(icon: Icon(Icons.show_chart), text: 'Regression'),
        Tab(icon: Icon(Icons.hub), text: 'Perceptron')]),
      const Expanded(child: TabBarView(children: [
        RegressionExperiment(), PerceptronExperiment()])),
    ]),
  );
}

class RegressionExperiment extends StatefulWidget {
  const RegressionExperiment({super.key});
  @override
  State<RegressionExperiment> createState() => _RegressionExperimentState();
}

class _RegressionExperimentState extends State<RegressionExperiment> {
  double slope = 1, intercept = 0;
  @override
  Widget build(BuildContext context) => PageBody(children: [
    const SectionTitle('Interactive / experiment 01', 'Fit a straight line',
      'Change the slope and intercept to minimise the prediction error.'),
    Card(child: Padding(padding: const EdgeInsets.all(18),
      child: Column(children: [
        const Wrap(spacing: 16, children: [
          Text('● Observations', style: TextStyle(color: teal)),
          Text('━ Model line', style: TextStyle(color: blue)),
        ]),
        const SizedBox(height: 10),
        SizedBox(height: 245, width: double.infinity,
          child: CustomPaint(painter: RegressionPainter(slope, intercept))),
      ]),
    )),
    const SizedBox(height: 10),
    Card(child: Padding(padding: const EdgeInsets.all(22),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('y = ' + slope.toStringAsFixed(1) + 'x ' +
          (intercept < 0 ? '− ' : '+ ') + intercept.abs().toStringAsFixed(1),
          style: const TextStyle(color: navy,
            fontWeight: FontWeight.w800, fontSize: 23)),
        const SizedBox(height: 7),
        Text('Mean squared error: ' +
          meanSquaredError(regressionSamples, slope, intercept).toStringAsFixed(2),
          style: const TextStyle(color: teal, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        Text('Slope: ' + slope.toStringAsFixed(1)),
        Slider(value: slope, min: -1, max: 4, divisions: 50,
          label: slope.toStringAsFixed(1),
          onChanged: (v) => setState(() => slope = v)),
        Text('Intercept: ' + intercept.toStringAsFixed(1)),
        Slider(value: intercept, min: -5, max: 5, divisions: 40,
          label: intercept.toStringAsFixed(1),
          onChanged: (v) => setState(() => intercept = v)),
        OutlinedButton.icon(
          onPressed: () => setState(() { slope = 1; intercept = 0; }),
          icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
      ]),
    )),
    const SizedBox(height: 12),
    const Hint('The closer the line is to the observations, the smaller the error. Try a slope near 2.'),
  ]);
}

class RegressionPainter extends CustomPainter {
  const RegressionPainter(this.slope, this.intercept);
  final double slope, intercept;
  @override
  void paint(Canvas canvas, Size size) {
    final w = math.max(1.0, size.width - 54);
    final h = math.max(1.0, size.height - 36);
    Offset xy(double x, double y) =>
      Offset(35 + x / 10 * w, 8 + (23 - y) / 25 * h);
    final grid = Paint()..color = const Color(0xffe8edf5)..strokeWidth = 1;
    for (var i = 0; i <= 10; i += 2) {
      canvas.drawLine(xy(i.toDouble(), -2), xy(i.toDouble(), 23), grid);
    }
    for (var i = 0; i <= 20; i += 5) {
      canvas.drawLine(xy(0, i.toDouble()), xy(10, i.toDouble()), grid);
    }
    canvas.drawLine(xy(0, intercept), xy(10, predictLine(10, slope, intercept)),
      Paint()..color = blue..strokeWidth = 3..strokeCap = StrokeCap.round);
    for (final sample in regressionSamples) {
      canvas.drawCircle(xy(sample.x, sample.y), 4.5, Paint()..color = teal);
      canvas.drawCircle(xy(sample.x, sample.y), 2, Paint()..color = Colors.white);
    }
  }
  @override
  bool shouldRepaint(covariant RegressionPainter old) =>
    slope != old.slope || intercept != old.intercept;
}

class PerceptronExperiment extends StatefulWidget {
  const PerceptronExperiment({super.key});
  @override
  State<PerceptronExperiment> createState() => _PerceptronExperimentState();
}

class _PerceptronExperimentState extends State<PerceptronExperiment> {
  int first = 1, second = 1;
  double a = 1, b = 1, bias = -1.5;
  @override
  Widget build(BuildContext context) {
    final sum = first * a + second * b + bias;
    final output = perceptron(first, second, a, b, bias);
    return PageBody(children: [
      const SectionTitle('Interactive / experiment 02', 'Build a tiny neuron',
        'Set two binary inputs, adjust weights, and reconstruct the AND gate.'),
      Card(child: Padding(padding: const EdgeInsets.all(22),
        child: Column(children: [
          Wrap(alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10, runSpacing: 10, children: [
              ValueChip('x₁', '$first'), const Icon(Icons.arrow_forward, color: blue),
              ValueChip('Σ', sum.toStringAsFixed(1)),
              const Icon(Icons.arrow_forward, color: blue),
              ValueChip('output', '$output'),
            ]),
          const SizedBox(height: 18),
          SwitchListTile(title: const Text('Input x₁'),
            value: first == 1,
            onChanged: (v) => setState(() => first = v ? 1 : 0)),
          SwitchListTile(title: const Text('Input x₂'),
            value: second == 1,
            onChanged: (v) => setState(() => second = v ? 1 : 0)),
        ]),
      )),
      const SizedBox(height: 10),
      Card(child: Padding(padding: const EdgeInsets.all(22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('AND gate: ' + andGateMatches(a, b, bias).toString() +
            ' / 4 combinations correct',
            style: const TextStyle(
              color: teal, fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 16),
          Text('Weight w₁: ' + a.toStringAsFixed(1)),
          Slider(value: a, min: -2, max: 2, divisions: 40,
            onChanged: (v) => setState(() => a = v)),
          Text('Weight w₂: ' + b.toStringAsFixed(1)),
          Slider(value: b, min: -2, max: 2, divisions: 40,
            onChanged: (v) => setState(() => b = v)),
          Text('Bias: ' + bias.toStringAsFixed(1)),
          Slider(value: bias, min: -3, max: 3, divisions: 60,
            onChanged: (v) => setState(() => bias = v)),
          OutlinedButton.icon(
            onPressed: () => setState(() {
              first = 1; second = 1; a = 1; b = 1; bias = -1.5;
            }),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Restore AND example')),
        ]),
      )),
      const SizedBox(height: 12),
      const Hint('AND outputs 1 only when both inputs are 1. Try all four input combinations.'),
    ]);
  }
}

class ValueChip extends StatelessWidget {
  const ValueChip(this.label, this.value, {super.key});
  final String label, value;
  @override
  Widget build(BuildContext context) => Container(
    width: 76, height: 74, alignment: Alignment.center,
    decoration: BoxDecoration(color: const Color(0xffedf0ff),
      borderRadius: BorderRadius.circular(18)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label, style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 5),
      Text(value, style: const TextStyle(color: navy,
        fontSize: 23, fontWeight: FontWeight.w800)),
    ]),
  );
}

class Hint extends StatelessWidget {
  const Hint(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(18),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Icon(Icons.lightbulb_outline, color: teal),
      const SizedBox(width: 12),
      Expanded(child: Text(message,
        style: const TextStyle(height: 1.5))),
    ]),
  ));
}
