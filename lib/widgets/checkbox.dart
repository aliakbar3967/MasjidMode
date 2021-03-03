import 'package:flutter/material.dart';

Widget fridayCheckbox(day, {name:"friday"}) => ListTile(
    onTap: () => !day,
    leading: Checkbox(
      value: day,
      onChanged: (value) => day = value
    ),
    title: Text(name),
  );