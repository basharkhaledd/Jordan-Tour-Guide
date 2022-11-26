import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/Screens/LoadingScreen.dart';
import 'package:tour_guide_app/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Icon(Icons.search),
            SizedBox(
              width: 15,
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade900,
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration:
                  const InputDecoration(labelText: 'Search for a site...'),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
        ),
        body: isShowUsers
            ? StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('sites').snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;

                            if (searchController.text.isEmpty) {
                              return ListTile(
                                title: Text(
                                  data['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data['previewimage']),
                                ),
                              );
                            }
                            if (data['title']
                                .toString()
                                .toLowerCase()
                                .startsWith(
                                    searchController.text.toLowerCase())) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoadingScreen(
                                          siteName: data['title'],
                                          governorate: data['governorates']),
                                    ),
                                  );
                                },
                                title: Text(
                                  data['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data['previewimage']),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                },
              )
            : Container());
  }
}
