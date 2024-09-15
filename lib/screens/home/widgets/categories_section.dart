import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/category/category_view.dart' as category_view;
import 'package:yoo_local/screens/home/widgets/custon_category_card.dart'
    as custom_category_card;

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Wines',
        'image': 'https://cdn-icons-png.flaticon.com/512/657/657261.png',
        "data": [
          {
            'name': 'Corona Extra Beer',
            'price': '£1.59',
            'image':
                'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
            'isFavorite': true,
            'description':
                'Corona Extra is a light, crisp Mexican Lager with a pale straw color...',
          },
          {
            'name': 'Cabernet Sauvignon',
            'price': '£10.99',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hc7/h36/8829289787422.png',
            'isFavorite': false,
            'description':
                'A full-bodied red wine with notes of dark fruit and a smooth finish...',
          },
          {
            'name': 'Pinot Noir',
            'price': '£12.50',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h22/h56/12307190726686.png',
            'isFavorite': true,
            'description':
                'This Pinot Noir offers a rich flavor with a balance of ripe fruit and subtle earthiness...',
          },
          {
            'name': 'Chardonnay',
            'price': '£8.75',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h6c/h25/12208472629214.png',
            'isFavorite': false,
            'description':
                'A popular white wine, Chardonnay brings a fresh, citrusy taste with hints of oak...',
          },
          {
            'name': 'Merlot',
            'price': '£11.25',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h48/hba/8800786309150.png',
            'isFavorite': true,
            'description':
                'Merlot is a smooth, medium-bodied red with flavors of black cherry and plum...',
          },
        ],
      },
      {
        'title': 'Beers',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
        "data": [
          {
            'name': 'Corona Extra Beer',
            'price': '£1.59',
            'image':
                'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
            'isFavorite': true,
            'description':
                'Corona Extra is a light, crisp Mexican Lager with a pale straw color...',
          },
          {
            'name': 'Cabernet Sauvignon',
            'price': '£10.99',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hc7/h36/8829289787422.png',
            'isFavorite': false,
            'description':
                'A full-bodied red wine with notes of dark fruit and a smooth finish...',
          },
          {
            'name': 'Pinot Noir',
            'price': '£12.50',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h22/h56/12307190726686.png',
            'isFavorite': true,
            'description':
                'This Pinot Noir offers a rich flavor with a balance of ripe fruit and subtle earthiness...',
          },
          {
            'name': 'Chardonnay',
            'price': '£8.75',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h6c/h25/12208472629214.png',
            'isFavorite': false,
            'description':
                'A popular white wine, Chardonnay brings a fresh, citrusy taste with hints of oak...',
          },
          {
            'name': 'Merlot',
            'price': '£11.25',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h48/hba/8800786309150.png',
            'isFavorite': true,
            'description':
                'Merlot is a smooth, medium-bodied red with flavors of black cherry and plum...',
          },
        ],
      },
      {
        'title': 'Spirits',
        'image':
            'https://cdn.icon-icons.com/icons2/3050/PNG/512/line_soda_sprite_icon_189443.png',
        "data": [
          {
            'name': 'Corona Extra Beer',
            'price': '£1.59',
            'image':
                'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
            'isFavorite': true,
            'description':
                'Corona Extra is a light, crisp Mexican Lager with a pale straw color...',
          },
          {
            'name': 'Cabernet Sauvignon',
            'price': '£10.99',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hc7/h36/8829289787422.png',
            'isFavorite': false,
            'description':
                'A full-bodied red wine with notes of dark fruit and a smooth finish...',
          },
          {
            'name': 'Pinot Noir',
            'price': '£12.50',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h22/h56/12307190726686.png',
            'isFavorite': true,
            'description':
                'This Pinot Noir offers a rich flavor with a balance of ripe fruit and subtle earthiness...',
          },
          {
            'name': 'Chardonnay',
            'price': '£8.75',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h6c/h25/12208472629214.png',
            'isFavorite': false,
            'description':
                'A popular white wine, Chardonnay brings a fresh, citrusy taste with hints of oak...',
          },
          {
            'name': 'Merlot',
            'price': '£11.25',
            'image':
                'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h48/hba/8800786309150.png',
            'isFavorite': true,
            'description':
                'Merlot is a smooth, medium-bodied red with flavors of black cherry and plum...',
          },
        ],
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
                products: category['data'],
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
                    builder: (context) => category_view.CategoryView(),
                  ));
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
