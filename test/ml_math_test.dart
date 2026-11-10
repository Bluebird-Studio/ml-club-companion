import 'package:flutter_test/flutter_test.dart';
import 'package:ml_club_companion/ml_math.dart';
import 'package:ml_club_companion/content.dart';

void main() {
  test('curriculum contains all fifteen weeks', () {
    expect(lessons.length, 15);
    expect(lessons.last.week, 15);
  });

  test('Week 1 quiz covers the seven approaches', () {
    expect(weekOneQuiz.length, 7);
    expect(weekOneQuiz.map((q) => q.answer).toSet(), approaches.toSet());
  });

  test('regression error is computed correctly', () {
    expect(predictLine(3, 2, 1), 7);
    expect(meanSquaredError([const Sample(1, 3), const Sample(2, 5)], 2, 1), 0);
  });

  test('perceptron learns a complete AND truth table', () {
    expect(andGateMatches(1, 1, -1.5), 4);
    expect(perceptron(0, 1, 1, 1, -1.5), 0);
    expect(perceptron(1, 1, 1, 1, -1.5), 1);
  });
}
