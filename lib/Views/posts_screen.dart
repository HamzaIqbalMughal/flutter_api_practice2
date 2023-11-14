import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_practice2/Models/post_model.dart';
import 'package:flutter_api_practice2/Views/view_post_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  String baseUrlOfInitials = 'https://api.dicebear.com/7.x/initials/svg?seed=';

  Future<String> getInitialsImage(String name) async {
    final response = await http.get(Uri.parse(
        baseUrlOfInitials + name + '&radius=50&backgroundType=gradientLinear'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load SVG from the API');
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
              child: FutureBuilder<List<PostModel>>(
                future: getPosts(),
                builder:
                    (context, AsyncSnapshot<List<PostModel>> snapshotPost) {
                  if (snapshotPost.hasData) {
                    return ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            radius: 40,
                            child: FutureBuilder<String>(
                              future: getInitialsImage(
                                  snapshotPost.data![index].title.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SvgPicture.string(
                                    snapshot.data.toString(),
                                    fit: BoxFit.contain,
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                                // if(snapshot.connectionState == ConnectionState.waiting){
                                //   return CircularProgressIndicator();
                                // }
                                // else if(snapshot.hasData){
                                //   return SvgPicture.string(snapshot.data.toString());
                                // }
                                // else{
                                //
                                // }
                              },
                            ),
                          ),
                          title:
                              Text(snapshotPost.data![index].title.toString()),
                          // dense: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostScreen(
                                    postModel: snapshotPost.data![index],
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
