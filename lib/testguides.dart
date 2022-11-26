import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView (
        children:[ Container(
         
          margin: EdgeInsets.only(top: 100,left: 10,right: 10),
          child: ListTile(
                  leading:  CircleAvatar(
                    // radius: 40,
                    foregroundImage: NetworkImage(
                        "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745"),
                  ),
                  
                  title: Text("bashar-qawasmi"),
                  subtitle: Text("aqaba,petra",style: TextStyle(color: Colors.black),),
                  trailing: 
                    Icon(Icons.call),
                     
                  ),
        ),
        Container(
       
        margin: EdgeInsets.only(top: 30,left: 10,right: 10),
        child: ListTile(
                leading:  CircleAvatar(
                  // radius: 40,
                  foregroundImage: NetworkImage(
                      "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745"),
                ),
                
                title: Text("bashar-qawasmi"),
                subtitle: Text("aqaba,petra",style: TextStyle(color: Colors.black),),
                trailing: 
                  Icon(Icons.call),
                   
                ),
      ),Container(
       
        margin: EdgeInsets.only(top: 30,left: 10,right: 10),
        child: ListTile(
                leading:  CircleAvatar(
                  // radius: 40,
                  foregroundImage: NetworkImage(
                      "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745"),
                ),
                
                title: Text("bashar-qawasmi"),
                subtitle: Text("aqaba,petra",style: TextStyle(color: Colors.black),),
                trailing: 
                Column(children: [
                  Icon(Icons.call),
                  Icon(Icons.chat),
                ],)
                  
                   
                ),
      ),
        ]
      ),
            
    );
  }
}