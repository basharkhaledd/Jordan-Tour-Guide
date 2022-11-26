import 'package:flutter/material.dart';

class Valleys extends StatefulWidget {
  const Valleys({super.key});

  @override
  State<Valleys> createState() => _ValleysState();
}

class _ValleysState extends State<Valleys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10,top: 20),
            child: Text(
              "Wellcome in jordan",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            alignment: Alignment.center,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              margin: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                 hintStyle: TextStyle(color: Colors.black),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search,color: Colors.black,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              )),
        ],
      ),
    );
  }
}
