import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                height: 200,
                child: CircleAvatar(
                  radius: 100,
                  foregroundImage: NetworkImage(
                      "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745"),
                )),
            Container(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  "bash qawasmi ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.call, size: 50),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.chat, size: 50),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.white,),
            

           
          ],
        ),
      ),
    );
  }
}
