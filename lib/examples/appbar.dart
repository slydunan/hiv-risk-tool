import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/theme.dart';

class CatalogAppBar extends AppBar {
  CatalogAppBar({super.key})
      : super(
          iconTheme: IconThemeData(
            color: appTheme.colorScheme.onPrimary, //change your color here
          ),
          backgroundColor: appTheme.colorScheme.primary,
          title: Text(
            "Provide info for your partner(s)",
            style: TextStyle(color: appTheme.colorScheme.onPrimary),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => print('icon1'),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => print('icon2'),
            ),
          ],
        );
}

class ResultsAppBar extends AppBar {
  ResultsAppBar({super.key})
      : super(
          iconTheme: IconThemeData(
            color: appTheme.colorScheme.onPrimary, //change your color here
          ),
          backgroundColor: appTheme.colorScheme.primary,
          title: Text(
            "View results",
            style: TextStyle(color: appTheme.colorScheme.onPrimary),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => print('icon1'),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => print('icon2'),
            ),
          ],
        );
}
