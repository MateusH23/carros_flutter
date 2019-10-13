import 'package:flutter/material.dart';

push(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}
