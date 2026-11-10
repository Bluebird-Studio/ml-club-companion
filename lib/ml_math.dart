class Sample {
  const Sample(this.x, this.y);
  final double x;
  final double y;
}

const regressionSamples = <Sample>[
  Sample(0, 1.1), Sample(1, 2.7), Sample(2, 5.2),
  Sample(3, 6.8), Sample(4, 9.2), Sample(5, 11.0),
  Sample(6, 12.7), Sample(7, 15.3), Sample(8, 17.0),
  Sample(9, 18.8), Sample(10, 21.1),
];

double predictLine(double x, double slope, double intercept) =>
    x * slope + intercept;

double meanSquaredError(List<Sample> points, double slope, double intercept) {
  if (points.isEmpty) return 0;
  var sum = 0.0;
  for (final point in points) {
    final error = predictLine(point.x, slope, intercept) - point.y;
    sum += error * error;
  }
  return sum / points.length;
}

int perceptron(int x1, int x2, double w1, double w2, double bias) =>
    x1 * w1 + x2 * w2 + bias >= 0 ? 1 : 0;

int andGateMatches(double w1, double w2, double bias) {
  var matches = 0;
  for (var a = 0; a <= 1; a++) {
    for (var b = 0; b <= 1; b++) {
      if (perceptron(a, b, w1, w2, bias) == (a & b)) matches++;
    }
  }
  return matches;
}
