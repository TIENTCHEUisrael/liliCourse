import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

AppBar buildAppBar(BuildContext context, Widget widget) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: const BackButton(
      color: Colors.black,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ],
    title: widget,
    centerTitle: true,
  );
}
