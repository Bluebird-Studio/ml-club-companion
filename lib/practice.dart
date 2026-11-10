import 'package:flutter/material.dart';
import 'content.dart';
import 'main.dart' show PageBody, SectionTitle, navy, blue, teal;
import 'explore.dart' show Hint;

class PracticePage extends StatefulWidget {
  const PracticePage({super.key, required this.best, required this.onResult});
  final int best;
  final ValueChanged<int> onResult;
  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  int position = 0, score = 0;
  String? selected;
  bool checked = false, finished = false;

  void check() {
    if (selected == null || checked) return;
    if (selected == weekOneQuiz[position].answer) score++;
    setState(() => checked = true);
  }

  void next() {
    if (position == weekOneQuiz.length - 1) {
      widget.onResult(score);
      setState(() => finished = true);
    } else {
      setState(() { position++; selected = null; checked = false; });
    }
  }

  void restart() => setState(() {
    position = 0; score = 0; selected = null;
    checked = false; finished = false;
  });

  @override
  Widget build(BuildContext context) {
    if (finished) {
      return PageBody(children: [
        const SectionTitle('Week 01 / practice', 'Challenge complete',
          'Review your score and try again to strengthen your understanding.'),
        Card(child: Padding(padding: const EdgeInsets.all(30),
          child: Column(children: [
            const Icon(Icons.verified_outlined, color: teal, size: 56),
            const SizedBox(height: 14),
            Text('$score / 7', style: const TextStyle(
              color: navy, fontSize: 48, fontWeight: FontWeight.w800)),
            const Text('Correct answers'),
            const SizedBox(height: 20),
            const Text('Your highest score is saved only in this browser or device.',
              textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton.icon(onPressed: restart,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Try again')),
          ]),
        )),
      ]);
    }
    final question = weekOneQuiz[position];
    return PageBody(children: [
      const SectionTitle('Week 01 / practice', 'Which kind of AI?',
        'Match seven real-world situations to the type of system that best explains them.'),
      Row(children: [
        const Text('QUESTION', style: TextStyle(color: blue,
          fontWeight: FontWeight.w800, letterSpacing: 1.4)),
        const Spacer(),
        Text((position + 1).toString() + ' / 7',
          style: const TextStyle(color: navy, fontWeight: FontWeight.w800)),
      ]),
      const SizedBox(height: 10),
      LinearProgressIndicator(
        value: (position + 1) / weekOneQuiz.length,
        minHeight: 7, borderRadius: BorderRadius.circular(7)),
      const SizedBox(height: 20),
      Card(child: Padding(padding: const EdgeInsets.all(24),
        child: Text(question.scenario,
          style: const TextStyle(color: navy, fontSize: 22,
            fontWeight: FontWeight.w800, height: 1.4)))),
      const SizedBox(height: 12),
      for (final option in approaches) ...[
        Card(child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: checked ? null : () => setState(() => selected = option),
          child: Padding(padding: const EdgeInsets.symmetric(
            horizontal: 18, vertical: 15),
            child: Row(children: [
              Icon(selected == option ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
                color: selected == option ? blue : const Color(0xffa0acbd)),
              const SizedBox(width: 13),
              Expanded(child: Text(option,
                style: const TextStyle(color: navy,
                  fontWeight: FontWeight.w700))),
            ]),
          ),
        )),
        const SizedBox(height: 3),
      ],
      if (checked) ...[
        const SizedBox(height: 10),
        Hint((selected == question.answer ? 'Correct. ' :
          'Correct answer: ' + question.answer + '. ') + question.explanation),
      ],
      const SizedBox(height: 16),
      FilledButton(
        onPressed: checked ? next : selected == null ? null : check,
        child: Text(checked ? (position == 6 ? 'See results' : 'Next question') :
          'Check answer')),
      const SizedBox(height: 12),
    ]);
  }
}
