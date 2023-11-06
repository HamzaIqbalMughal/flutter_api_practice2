import 'package:flutter/material.dart';
import 'package:flutter_api_practice2/Models/post_model.dart';

class ViewPostScreen extends StatefulWidget {
  // const ViewPostScreen({super.key});

  PostModel postModel ;

  ViewPostScreen({ required this.postModel});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(

        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Text(widget.postModel.title.toString()),
      ),
    );
  }
}
