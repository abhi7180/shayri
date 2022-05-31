import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayri/data.dart';
import 'package:shayri/shayrilist.dart';
import 'package:shayri/sizedata.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class viewdemo extends StatefulWidget {
  const viewdemo({Key? key}) : super(key: key);

  @override
  _viewdemoState createState() => _viewdemoState();
}

class _viewdemoState extends State<viewdemo> {

  PageController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(
      initialPage: 1
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(

        controller: controller,
        onPageChanged: (value) {
          print(value);
        },
        scrollDirection: Axis.vertical,
        itemCount: data.catlist.length,
        itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12
          ),
          child: Text(data.catlist[index]),
        );
      },)
    );
  }
}
class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}
class _demoState extends State<demo> {

  permission()async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
    var status = await Permission.storage.status;
    if (status.isGranted) {
      createFolder().then((value) {
        print(value);
        setState(() {
          data.folderpath=value;
        });
      });
    }
    else {
       permission();
      }
  }
  Future<String> createFolder() async {
    final folderName = "Myfolder";
    var defaultpath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    final path = Directory("$defaultpath/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }
  @override
  Widget build(BuildContext context) {
    sizedeta(context);
    return Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff219F94),title: Padding(
          padding: const EdgeInsets.only(left: 140),
          child: Text("SHAYRI",style: TextStyle(fontSize : 25,color: Color(0xffF2F5C8)),),
        ),),
        body: Container(
          color: Color(0xffC1DEAE),
          child: ListView.builder(
            itemCount: data.imagelist.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xffF2F5C8),
                child: ListTile(
                  title: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("${data.catlist[index]}",style: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 18,
                          color: Color(0xff219F94)),)),
                   leading:Container(
                     height:  sizedeta.width!/9,
                     width: sizedeta.width!/9,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage(data.imagelist[index],),
                         fit: BoxFit.fill
                       ),
                       shape: BoxShape.circle

                     ),
                   ),
                    trailing: Icon(Icons.navigate_next,size: 30,color: Color(0xff219F94),),

                    onTap: () {
                    Navigator.push(context , MaterialPageRoute(builder: (context) {
                      return shayrilist(index, data.catlist[index]);
                    },));

                    },
                ),
              );
            }, ),
        )
    );
  }
}

