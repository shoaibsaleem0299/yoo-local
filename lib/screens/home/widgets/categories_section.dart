import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/category/category_view.dart' as category_view;
import 'package:yoo_local/screens/home/widgets/custon_category_card.dart'
    as custom_category_card;

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {
        'title': 'Wines',
        'image': 'https://cdn-icons-png.flaticon.com/512/657/657261.png',
      },
      {
        'title': 'Beers',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      },
      {
        'title': 'Spirits',
        'image':
            'https://cdn.icon-icons.com/icons2/3050/PNG/512/line_soda_sprite_icon_189443.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories.map((category) {
              return custom_category_card.CategoryCard(
                title: category['title']!,
                imageUrl: category['image']!,
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 160,
              endIndent: 160,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => category_view.CategoryView()));
            },
            child: Text(
              "View All",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
