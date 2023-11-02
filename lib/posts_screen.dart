import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_practice2/Models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  String url = 'https://jsonplaceholder.typicode.com/posts';

  List<PostModel> postsList = [];

  Future<List<PostModel>> getPosts () async {
    final response = await http.get(Uri.parse(url));

    var data =jsonDecode(response.body.toString());

    if(response == 200){
      for(Map i in data){

        postsList.add(PostModel.fromJson(i));
        // PostModel(
        //   userId: i['userId'],
        //     id: i['id'],
        //     title: i['title'],
        //     body: i['body'],
        // );
      }
      return postsList;
    }
    else{
      return postsList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(

                )
            )
          ],
        ),
      ),
    );
  }
}
