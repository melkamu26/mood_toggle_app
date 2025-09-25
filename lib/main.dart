import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MoodModel(),
      child: const MoodApp(),
    ),
  );
}

class MoodModel with ChangeNotifier {
  String _assetPath = 'assets/images/happy.png';
  String get assetPath => _assetPath;

  void setHappy() {
    _assetPath = 'assets/images/happy.png';
    notifyListeners();
  }

  void setSad() {
    _assetPath = 'assets/images/sad.png';
    notifyListeners();
  }

  void setExcited() {
    _assetPath = 'assets/images/excited.png';
    notifyListeners();
  }
}

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Toggle Challenge')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 24),
                MoodDisplay(),
                SizedBox(height: 32),
                MoodButtons(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: color.surface,
    );
  }
}

class MoodDisplay extends StatelessWidget {
  const MoodDisplay({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (_, mood, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: ClipRRect(
            key: ValueKey(mood.assetPath),
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              mood.assetPath,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
          ),
        );
      },
    );
  }
}

class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});
  @override
  Widget build(BuildContext context) {
    final mood = Provider.of<MoodModel>(context, listen: false);
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: mood.setHappy,
          icon: const Icon(Icons.sentiment_satisfied_alt),
          label: const Text('Happy'),
        ),
        ElevatedButton.icon(
          onPressed: mood.setSad,
          icon: const Icon(Icons.sentiment_dissatisfied),
          label: const Text('Sad'),
        ),
        ElevatedButton.icon(
          onPressed: mood.setExcited,
          icon: const Icon(Icons.celebration),
          label: const Text('Excited'),
        ),
      ],
    );
  }
}