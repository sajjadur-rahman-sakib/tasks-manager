import 'package:flutter/material.dart';
import 'package:sakib/ui/utility/app_colors.dart';

AppBar profileAppBar() {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(),
    ),
    title: const Column(
      children: [
        Text(
          'Sajjadur Rahman',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'sakib.x@icloud.com',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.logout),
      )
    ],
  );
}
