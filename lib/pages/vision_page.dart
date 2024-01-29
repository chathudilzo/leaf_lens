import 'package:flutter/material.dart';

class VisionPage extends StatefulWidget {
  const VisionPage({super.key});

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      color: Colors.red,
    );
  }
}