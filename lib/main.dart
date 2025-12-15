import 'package:flutter/material.dart';

void main() => runApp(const SxodimApp());

class SxodimApp extends StatelessWidget {
  const SxodimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sxodim Aktobe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const BottomNavController(),
    );
  }
}

/// BOTTOM NAVIGATION

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int index = 0;

  final screens = [
    HomeScreen(),
    SettingsScreen(),
  ];

  final titles = [
    "События",
    "Настройки",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[index]),
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "События",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Настройки",
          ),
        ],
      ),
    );
  }
}

/// HOME — СОБЫТИЯ

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> events = [
    {
      "title": "Новогодний Mantra Fest",
      "date": "14 Декабря",
      "time": "17:30",
      "price": "3000 ₸",
      "place": "пр. Тауелсиздик 9/1, С2 Коворкинг",
      "image":
          "https://images.pexels.com/photos/10250346/pexels-photo-10250346.jpeg",
      "description":
          "Приглашаем вас на Новогодний Mantra Fest — атмосферный концерт мантр в индийском стиле.",
      "organizer": "Sxodim Aqtobe Event Group"
    },
    {
      "title": "Детский мастер-класс по приготовлению пиццы",
      "date": "14 Июля",
      "time": "10:00 - 20:00",
      "price": "3000 ₸",
      "place": "Адреса: пр.Абилкайыр Хана 52; пр.Абилкайыр Хана 75; ул.Н.Шайкенова 6",
      "image":
          "https://images.pexels.com/photos/33593006/pexels-photo-33593006.jpeg",
      "description":
          "Ваши дети смогут почувствовать себя в роли пиццамейкеров! В Додо раскроют все секреты вкусной пиццы, помогут приготовить кулинарный шедевр, а ещё проведут экскурсию по кухне и ответят на все вопросы! Такую радость для ваших деток устраивают в будние дни. Записать ребёнка на мастер-класс по приготовлению пиццы можно на сайте.Мастер-класс бесплатный. Оплачивается лишь стоимость пиццы, которую приготовит ребёнок, а затем с удовольствием съест вместе с вами!",
      "organizer": "Dodo pizza"
    },
    {
      "title": "JAZĞY MOUNT",
      "date": "15 Июля",
      "time": "21:00",
      "price": "4000 ₸",
      "place": "Адреса: улица Отегена Турмагамбетова, 50 Арт-пространство Fabrika, локация «Двор Photoyou»",
      "image":
          "https://images.pexels.com/photos/33597/guitar-classical-guitar-acoustic-guitar-electric-guitar.jpg",
      "description":
          "Сохраните оттенки Mount в летних воспоминаниях!",
      "organizer": "JAZĞY MOUNT"
    },
    {
      "title": "Первенство города Актобе Kazchrome-Duathlon",
      "date": "16 Июля",
      "time": "21:00",
      "price": "2000 ₸",
      "place": "Триатлон парк",
      "image":
          "https://images.pexels.com/photos/37836/silhouette-fitness-bless-you-bike-37836.jpeg",
      "description":
          "«Эстафета TEAM» - командная эстафета. Ваша команда должна состоять из двух парней и одной девушки.",
      "organizer": "Sxodim Aqtobe Event Group"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final item = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventDetailsScreen(event: item),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    item["image"]!,
                    fit: BoxFit.cover,       
                  ),
                ),
                ListTile(
                  title: Text(
                    item["title"]!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${item['date']} • ${item['place']}"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// EVENT DETAILS

class EventDetailsScreen extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event["title"]!)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                event["image"]!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            section("Дата", event["date"]!),
            section("Время", event["time"]!),
            section("Цена", event["price"]!),
            section("Место", event["place"]!),
            section("Описание", event["description"]!),
            section("Организатор", event["organizer"]!),

            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: const Text(
                "Купить билет",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget section(String title, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      );
}


/// SETTINGS

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool push = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text("Push-уведомления"),
          value: push,
          activeColor: Colors.red,
          onChanged: (v) => setState(() => push = v),
        ),
        const ListTile(
          title: Text("О приложении"),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

