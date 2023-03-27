import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/banner_widget.dart';
import 'widgets/category_text.dart';
import 'widgets/search_input_widget.dart';
import 'widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          WelcomeText(),
          SizedBox(
            height: 14,
          ),
          SearchInputWidget(),
          BannerWidget(),
          CategoryText(),
        ],
      ),
    );
  }
}
