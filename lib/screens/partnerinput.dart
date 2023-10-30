// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/results.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/common/theme.dart';
import 'package:flutter_application_1/models/partners.dart';
import 'package:flutter_application_1/examples/appbar.dart';
import 'package:flutter_application_1/screens/formwidget.dart';

class MyPartners extends StatelessWidget {
  const MyPartners({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PartnerModel>(context, listen: false);

    return Scaffold(
      appBar: CatalogAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<PartnerModel>(
            builder: (context, partners, child) => Container(
              constraints: const BoxConstraints(
                  minHeight: 20, minWidth: double.infinity, maxHeight: 500),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: partners.partners.length,
                  itemBuilder: (BuildContext context, int index) {
                    Partner thisPartner = partners.partners[index];
                    return ListTile(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                //title: const Text("Warning"),
                                content: const Text(
                                    "Partner editing is in development."),
                                actions: [
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }),
                        leading: const Icon(Icons.person),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => model.remove(thisPartner)),
                        title: Text(
                            "Partner $index: ${thisPartner.name} (${thisPartner.hivStatus} ${double.parse((thisPartner.hivProb * 100).toStringAsFixed(2))}%)"));
                  }),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add a new partner ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors
                            .white) //style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                    ),
                Icon(Icons.add, color: Colors.white)
              ],
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return FormWidget();
                }),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Calculate Results  ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .white) //style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                      ),
                  Icon(Icons.analytics, color: Colors.white)
                ],
              ),
              onPressed: () => DefaultTabController.of(context).animateTo(2)),
          const Expanded(
            child: SizedBox.expand(),
          ),
          const Expanded(
            child: SizedBox.expand(),
          ),
        ],
      ),
    );
  }
}
