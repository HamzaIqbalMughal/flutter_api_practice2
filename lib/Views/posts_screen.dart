import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_practice2/Models/post_model.dart';
import 'package:flutter_api_practice2/Views/view_post_screen.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  String url = 'https://jsonplaceholder.typicode.com/posts';

  List<PostModel> postsList = [];

  Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        postsList.add(PostModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(

                          contentPadding: EdgeInsets.all(0),
                          leading: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://api.dicebear.com/7.x/adventurer/svg?seed=Chester',
                            ),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                          // dense: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostScreen(
                                    postModel: snapshot.data![index],
                                    postNumber: index + 1),
                              ),
                            );
                          },
                          subtitle: Text("Post # ${index + 1}"),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        strokeWidth: 5,
                        strokeAlign: 5,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
