import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String heading;
  final String imageURL;
  final void Function()? onChangeFunction;
  final String? trailing;

  const SectionHeader({
    super.key,
    required this.heading,
    required this.imageURL,
    this.onChangeFunction,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 32, right: 32, bottom: 0),
      child: Row(
        children: [
          Image.network(
            imageURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image,
                  color: Colors.grey, size: 50);
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              heading,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (trailing != null)
            GestureDetector(
              onTap: onChangeFunction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailing!,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
