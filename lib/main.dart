import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

class MoodModel with ChangeNotifier {
  String _currentMood = 'happy';
  Color _backgroundColor = Colors.yellow;

  final Map<String, int> _moodCounts = {
    'happy': 0,
    'sad': 0,
    'excited': 0,
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = 'happy';
    _backgroundColor = Colors.yellow;
    _moodCounts['happy'] = _moodCounts['happy']! + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'sad';
    _backgroundColor = Colors.blue;
    _moodCounts['sad'] = _moodCounts['sad']! + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'excited';
    _backgroundColor = Colors.orange;
    _moodCounts['excited'] = _moodCounts['excited']! + 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return MaterialApp(
          title: 'Mood Toggle Challenge',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.backgroundColor,
          appBar: AppBar(title: const Text('Mood Toggle Challenge')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('How are you feeling?',
                    style: TextStyle(fontSize: 24)),
                const SizedBox(height: 30),
                MoodDisplay(),
                const SizedBox(height: 50),
                MoodButtons(),
                const SizedBox(height: 30),
                const Text(
                  'Mood Counter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                MoodCounter(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        String imagePath;
        switch (moodModel.currentMood) {
          case 'happy':
            imagePath = 'assets/images/happy.png';
            break;
          case 'sad':
            imagePath = 'assets/images/sad.png';
            break;
          case 'excited':
            imagePath = 'assets/images/excited.png';
            break;
          default:
            imagePath = 'assets/images/happy.png';
        }
        return Image.asset(imagePath, width: 150, height: 150);
      },
    );
  }
}

class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setHappy(),
          child: const Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setSad(),
          child: const Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setExcited(),
          child: const Text('Excited 🎉'),
        ),
      ],
    );
  }
}

class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Text("Happy: ${moodModel.moodCounts['happy']}"),
            Text("Sad: ${moodModel.moodCounts['sad']}"),
            Text("Excited: ${moodModel.moodCounts['excited']}"),
          ],
        );
      },
    );
  }
}