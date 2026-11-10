import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'content.dart';
import 'explore.dart';
import 'practice.dart';

const navy = Color(0xff172747);
const blue = Color(0xff4057d6);
const teal = Color(0xff0c857d);
const pale = Color(0xfff6f8fc);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CompanionApp());
}

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Machine Learning Club Companion',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: pale,
      colorScheme: ColorScheme.fromSeed(
        seedColor: blue, primary: blue, secondary: teal, surface: Colors.white),
      cardTheme: CardThemeData(
        color: Colors.white, elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xffe5e9f4)))),
      appBarTheme: const AppBarTheme(
        color: pale, foregroundColor: navy, elevation: 0),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)))),
    ),
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int active = 0, best = -1;
  final visited = <int>{};
  SharedPreferences? storage;

  @override
  void initState() { super.initState(); load(); }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      storage = prefs;
      best = prefs.getInt('week1_best_score') ?? -1;
      visited.addAll((prefs.getStringList('opened_lessons') ?? [])
        .map(int.tryParse).whereType<int>());
    });
  }

  void visit(int week) {
    if (visited.add(week)) {
      setState(() {});
      final keys = visited.toList()..sort();
      storage?.setStringList('opened_lessons',
        keys.map((n) => n.toString()).toList());
    }
  }

  void saveScore(int value) {
    if (value > best) {
      setState(() => best = value);
      storage?.setInt('week1_best_score', value);
    }
  }

  void reset() {
    setState(() { visited.clear(); best = -1; });
    storage?.remove('opened_lessons');
    storage?.remove('week1_best_score');
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Home', 'Lessons', 'Playground', 'Practice', 'Progress'];
    const icons = [
      Icons.home_outlined, Icons.menu_book_outlined, Icons.scatter_plot_outlined,
      Icons.check_circle_outline, Icons.insights_outlined,
    ];
    final sections = <Widget>[
      HomePage(best: best, opened: visited.length, navigate: (n) => setState(() => active = n)),
      LessonsPage(visited: visited, onVisit: visit),
      const ExplorePage(),
      PracticePage(best: best, onResult: saveScore),
      ProgressPage(best: best, opened: visited.length, reset: reset),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 820;
      final body = Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: sections[active]));
      return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 38, height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [blue, Color(0xff7584f0)]),
                borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.hub_rounded, color: Colors.white, size: 23)),
            const SizedBox(width: 12),
            const Flexible(child: Text('ML Club Companion',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18,
                letterSpacing: -.5))),
          ]),
          actions: [
            if (wide) const Padding(padding: EdgeInsets.only(right: 14),
              child: Center(child: Text('SEVEN HILLS · 2026–27',
                style: TextStyle(fontSize: 11, color: Color(0xff78859b),
                  fontWeight: FontWeight.w700, letterSpacing: 1.2)))),
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              tooltip: 'About the app',
              onPressed: () => showAboutDialog(
                context: context,
                applicationName: 'Machine Learning Club Companion',
                applicationVersion: '0.1.0 Web preview',
                children: [const Text(
                  'Core lessons and experiments work offline. Progress is stored locally. No account, tracking or ads.')]),
            ),
            const SizedBox(width: 6),
          ]),
        body: wide ? Row(children: [
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: active,
            onDestinationSelected: (n) => setState(() => active = n),
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (var i = 0; i < titles.length; i++)
                NavigationRailDestination(
                  icon: Icon(icons[i]), label: Text(titles[i])),
            ]),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ]) : body,
        bottomNavigationBar: wide ? null : NavigationBar(
          height: 72,
          selectedIndex: active,
          onDestinationSelected: (n) => setState(() => active = n),
          destinations: [
            for (var i = 0; i < titles.length; i++)
              NavigationDestination(icon: Icon(icons[i], size: 22), label: titles[i]),
          ]),
      );
    });
  }
}

class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(22, 24, 22, 44), children: children);
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.eyebrow, this.title, this.subtitle, {super.key});
  final String eyebrow, title, subtitle;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(eyebrow.toUpperCase(), style: const TextStyle(
        color: blue, fontWeight: FontWeight.w800, fontSize: 11,
        letterSpacing: 1.8)),
      const SizedBox(height: 9),
      Text(title, style: const TextStyle(
        color: navy, fontSize: 30, fontWeight: FontWeight.w800,
        letterSpacing: -1, height: 1.15)),
      const SizedBox(height: 10),
      Text(subtitle, style: const TextStyle(
        color: Color(0xff657388), fontSize: 15, height: 1.5)),
      const SizedBox(height: 22),
    ]);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.best,
    required this.opened, required this.navigate});
  final int best, opened;
  final ValueChanged<int> navigate;

  @override
  Widget build(BuildContext context) => PageBody(children: [
    Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff142542), Color(0xff314a9d)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(25)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('YOUR LEARNING JOURNEY', style: TextStyle(
          color: Color(0xffadbeff), fontSize: 11,
          fontWeight: FontWeight.w800, letterSpacing: 1.8)),
        const SizedBox(height: 15),
        const Text('Make sense of\nintelligent systems.',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,
            fontSize: 36, letterSpacing: -1.3, height: 1.12)),
        const SizedBox(height: 15),
        const Text('Explore algorithms, experiment with parameters, and learn how machines make decisions.',
          style: TextStyle(color: Color(0xffdce5ff), height: 1.6, fontSize: 15)),
        const SizedBox(height: 22),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white, foregroundColor: navy),
          onPressed: () => navigate(3),
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start Week 1 challenge')),
        const SizedBox(height: 15),
        const Text('15 lessons  ·  2 experiments  ·  7 quiz questions',
          style: TextStyle(color: Color(0xffbfcdff), fontSize: 12)),
      ]),
    ),
    const SizedBox(height: 25),
    const Text('Choose your next step', style: TextStyle(
      color: navy, fontSize: 22, fontWeight: FontWeight.w800)),
    const SizedBox(height: 12),
    LayoutBuilder(builder: (context, size) {
      final one = FeatureCard(Icons.menu_book_outlined, 'Learn',
        'A complete 15-week roadmap with lessons, activities and resources.',
        'Browse lessons', () => navigate(1));
      final two = FeatureCard(Icons.scatter_plot_outlined, 'Explore',
        'See regression and neural-network predictions change in real time.',
        'Try playgrounds', () => navigate(2));
      if (size.maxWidth > 650) {
        return Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: one), const SizedBox(width: 12),
            Expanded(child: two)]);
      }
      return Column(children: [one, const SizedBox(height: 8), two]);
    }),
    const SizedBox(height: 16),
    Card(child: Padding(padding: const EdgeInsets.all(20),
      child: Row(children: [
        const Icon(Icons.auto_graph, color: blue),
        const SizedBox(width: 12),
        Expanded(child: Text('Lessons opened: $opened/15 · Best quiz: ' +
          (best < 0 ? 'not attempted' : '$best/7'),
          style: const TextStyle(fontWeight: FontWeight.w600))),
        TextButton(onPressed: () => navigate(4), child: const Text('View')),
      ]))),
  ]);
}

class FeatureCard extends StatelessWidget {
  const FeatureCard(this.icon, this.title, this.description, this.action,
    this.open, {super.key});
  final IconData icon;
  final String title, description, action;
  final VoidCallback open;
  @override
  Widget build(BuildContext context) => Card(clipBehavior: Clip.antiAlias,
    child: InkWell(onTap: open, child: Padding(
      padding: const EdgeInsets.all(23),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 46, height: 46,
          decoration: BoxDecoration(color: const Color(0xffedf0ff),
            borderRadius: BorderRadius.circular(13)),
          child: Icon(icon, color: blue)),
        const SizedBox(height: 15),
        Text(title, style: const TextStyle(
          color: navy, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(description, style: const TextStyle(
          color: Color(0xff69778a), height: 1.5)),
        const SizedBox(height: 15),
        Row(children: [
          Text(action, style: const TextStyle(
            color: blue, fontWeight: FontWeight.w800)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_rounded, color: blue, size: 18),
        ]),
      ]),
    )));
}

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key, required this.visited, required this.onVisit});
  final Set<int> visited;
  final ValueChanged<int> onVisit;

  @override
  Widget build(BuildContext context) => PageBody(children: [
    const SectionTitle('Learning path', 'Fifteen weeks of discovery',
      'Follow the classroom programme and use the course, lab, homework and advanced resources for each week.'),
    for (final lesson in lessons) ...[
      Card(child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Container(width: 46, height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: visited.contains(lesson.week)
              ? const Color(0xffe1f5ed) : const Color(0xffedf0ff),
            borderRadius: BorderRadius.circular(13)),
          child: Text(lesson.week.toString().padLeft(2, '0'),
            style: TextStyle(color: visited.contains(lesson.week) ? teal : blue,
              fontWeight: FontWeight.w800, fontSize: 17))),
        title: Text(lesson.title, style: const TextStyle(
          color: navy, fontWeight: FontWeight.w800)),
        subtitle: Text(lesson.date),
        trailing: Icon(visited.contains(lesson.week)
          ? Icons.check_circle_outline : Icons.chevron_right, color: blue),
        onTap: () {
          onVisit(lesson.week);
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => LessonDetail(lesson: lesson)));
        },
      )),
      const SizedBox(height: 5),
    ],
  ]);
}

class LessonDetail extends StatelessWidget {
  const LessonDetail({super.key, required this.lesson});
  final ClubLesson lesson;

  Future<void> open(BuildContext context, String type) async {
    final ok = await launchUrl(Uri.parse(lesson.resource(type)));
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the external resource.')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Week ' + lesson.week.toString())),
    body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: PageBody(children: [
        SectionTitle('Week ' + lesson.week.toString() + ' · ' + lesson.date,
          lesson.title, lesson.description),
        Card(child: Padding(padding: const EdgeInsets.all(22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Learning objective', style: TextStyle(
              color: navy, fontSize: 19, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text(lesson.description, style: const TextStyle(
              fontSize: 16, height: 1.5)),
            const SizedBox(height: 14),
            const Text('What goes in, what comes out, and how can we check the result?',
              style: TextStyle(color: Color(0xff66768a), height: 1.5)),
          ]))),
        const SizedBox(height: 20),
        const Text('Course resources', style: TextStyle(
          color: navy, fontSize: 19, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        const Text('External resources open the club website and require internet.'),
        for (final type in const ['course', 'lab', 'homework', 'advanced'])
          Card(child: ListTile(
            leading: const Icon(Icons.open_in_new, color: blue),
            title: Text(type == 'lab' ? 'Laboratory' :
              type[0].toUpperCase() + type.substring(1)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => open(context, type),
          )),
      ]),
    )),
  );
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key, required this.best,
    required this.opened, required this.reset});
  final int best, opened;
  final VoidCallback reset;

  @override
  Widget build(BuildContext context) => PageBody(children: [
    const SectionTitle('Your learning record', 'Progress that stays yours',
      'No account or leaderboard. This app stores progress in the browser or on the device.'),
    Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.menu_book_outlined, color: blue, size: 28),
        const SizedBox(height: 15),
        Text('$opened / 15', style: const TextStyle(
          color: navy, fontSize: 35, fontWeight: FontWeight.w800)),
        const Text('Lessons explored'),
      ]))),
    Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.verified_outlined, color: teal, size: 28),
        const SizedBox(height: 15),
        Text(best < 0 ? 'Not attempted' : '$best / 7', style: const TextStyle(
          color: navy, fontSize: 30, fontWeight: FontWeight.w800)),
        const Text('Best Week 1 quiz score'),
      ]))),
    const SizedBox(height: 16),
    OutlinedButton.icon(
      onPressed: () async {
        final confirmed = await showDialog<bool>(context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Clear progress?'),
            content: const Text('This removes lesson visits and quiz scores saved locally.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
              FilledButton(onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Clear')),
            ]));
        if (confirmed == true) reset();
      },
      icon: const Icon(Icons.delete_outline),
      label: const Text('Clear local progress')),
  ]);
}
