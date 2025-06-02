import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper.dart' show Wallpaper;


void main(){
  runApp(HoneScreen());
}
class HoneScreen extends StatefulWidget {
  const HoneScreen({super.key});

  @override
  State<HoneScreen> createState() => _HoneScreenState();
}

class _HoneScreenState extends State<HoneScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wallpaper(),
    );
  }
}
