import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars_app/main.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var currentLocale = context.locale;
    var listOfLanguage = supportedLocalization.map((locale) => locale.languageCode).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings')),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tr('select_language')),

                  DropdownButton<String>(
                    value: currentLocale.languageCode,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      _onLanguageChanged(context, newValue);
                      if(newValue != null) {

                      }
                    },
                    items: listOfLanguage
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLanguageChanged(BuildContext context, String? newValue) {
    if(newValue != null) {
      Locale newLocale = supportedLocalization.firstWhere(
              (element) => element.languageCode == newValue
      );

      context.setLocale(newLocale);
    }
  }

}

