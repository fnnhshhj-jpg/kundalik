import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const KundalikApp());
}

class KundalikApp extends StatelessWidget {
  const KundalikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kundalik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String savedText = "";

  @override
  void initState() {
    super.initState();
    loadText();
  }

  Future<void> loadText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedText = prefs.getString("kundalik") ?? "";
    });
  }

  Future<void> saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("kundalik", controller.text);

    setState(() {
      savedText = controller.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saqlandi ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📔 Kundalik"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Bugungi yozuv",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 15),

            TextField(
              controller: controller,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "Bugun nimalar bo‘ldi?",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: saveText,
              child: const Text("Saqlash"),
            ),

            const SizedBox(height: 20),

            if (savedText.isNotEmpty)
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(savedText),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
