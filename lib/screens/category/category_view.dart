import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  // List of available colors

  // Mock data as an array of maps (could later be fetched from an API)
  List<Map<String, String>> categories = [
    {
      "name": "Wine",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Beer",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Spirits",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Chocolates",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Crips",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Biscuits",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Snacks",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Soft Drinks",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Extra1",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Extra2",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Extra3",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Extra4",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
    {
      "name": "Extra5",
      "image": "https://cdn-icons-png.flaticon.com/512/657/657261.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      name: category['name']!,
                      color: const Color.fromARGB(255, 241, 212, 170),
                    ),
                  ),
                );
              },
              child: CategoryCard(
                name: category['name']!,
                imageUrl: category['image']!,
                color: const Color.fromARGB(255, 241, 212, 170),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Color color;

  const CategoryCard({
    required this.name,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 42),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: imageUrl,
                  width: 70,
                  fit: BoxFit.contain,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/error_image.png', // Path to a local error image
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String name;
  final Color color;

  const ResultScreen({
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
        backgroundColor: color,
      ),
      body: Center(
        child: Text(
          'Results for $name',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
