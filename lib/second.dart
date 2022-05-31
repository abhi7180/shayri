import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri/data.dart';
import 'package:shayri/sizedata.dart';

import 'dart:async';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class second extends StatefulWidget {
  List templist;
  int pos;
  String colortype;

  second(this.templist, this.pos, this.colortype);

  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> {
  double textval = 10;
  String emojiset = "";
  Color mybkclr = Colors.white;
  Color mytxclr = Colors.black;
  String fontlist1 = "";
  List<Color> mybkrgb = [Colors.white, Colors.white];
  GlobalKey _globalKey = new GlobalKey();
  List<Color> currentgradient = [];
  Future<Uint8List> _capturePng() async {
    var pngBytes;
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
    } catch (e) {}
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {

    data();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff219F94),
      ),
      body: Container(
          color: Color(0xffC1DEAE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RepaintBoundary(
                child: Container(
                  height: sizedeta.height! / 2.5,
                  width: sizedeta.width! - 50,
                  decoration: BoxDecoration(
                      color: widget.colortype == "singlecolor" ? mybkclr : null,
                      gradient: widget.colortype == "gradient"
                          ? LinearGradient(colors: currentgradient)
                          : null,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Text(
                      "$emojiset \n ${widget.templist[widget.pos]} \n $emojiset",
                      style: TextStyle(
                        fontSize: textval,
                        fontFamily: fontlist1,
                        color: mytxclr,
                      ),
                    ),
                  ),
                ),
                key: _globalKey,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sizedeta.bdheight,
                                    child: GridView.builder(
                                      itemCount: data.rgbclr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 3),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget.colortype = "gradient";
                                              currentgradient =
                                                  data.rgbclr[index];
                                              print("${data.rgbclr[index]}");
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors:
                                                        data.rgbclr[index])),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.shuffle,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.colortype = "gradient";
                                data.rgbclr.shuffle();
                                currentgradient = data.rgbclr[1];
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_return_rounded,
                              size: 30,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 200,
                                    child: GridView.builder(
                                      itemCount: data.clr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget.colortype = "singlecolor";
                                              mybkclr = data.clr[index];
                                            });
                                          },
                                          child: Container(
                                            color: data.clr[index],
                                          ),
                                        );
                                      },
                                    ));
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Background",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 200,
                                    child: GridView.builder(
                                      itemCount: data.clr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              mytxclr = data.clr[index];
                                            });
                                          },
                                          child:
                                              Container(color: data.clr[index]),
                                        );
                                      },
                                    ));
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Text Color",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _capturePng().then((imgbyte) {
                              var now = new DateTime.now();
                              var formatter = DateFormat('ddmmyy');

                              String actualDate = formatter.format(now);

                              String time =
                                  "${now.hour.toString()}${now.minute.toString()}${now.microsecond.toString()}";
                              String imgname = "IMG_${actualDate}${time}";
                              File f = File("${data.folderpath}/$imgname.jpg");
                              f.create().then((value) {
                                f.writeAsBytes(imgbyte).then((value) {
                                  // Fluttertoast.showToast(msg: "img download",);
                                  Share.shareFiles(['${value.path}']);
                                });
                              });
                            });
                          },
                          child: Container(
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Share",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Font",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.fontlist.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              fontlist1 = data.fontlist[index];
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 30, right: 20),
                                            child: Text(
                                              "hello",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily:
                                                      data.fontlist[index]),
                                            ),
                                          ));
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              // isDismissible: false,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: data.emoji1.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            emojiset = data.emoji1[index];
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 70),
                                          child: Text(
                                            "${data.emoji1[index]}\n",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Emoji",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 100,
                                  child: StatefulBuilder(
                                    builder: (context, setState1) {
                                      return Slider(
                                        onChanged: (value) {
                                          setState(() {
                                            setState1(() {
                                              textval = value;
                                            });
                                          });
                                        },
                                        value: textval,
                                        min: 10,
                                        max: 50,
                                        activeColor: Color(0xff219F94),
                                        inactiveColor: Color(0xffF2F5C8),
                                        thumbColor: Colors.black,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: sizedeta.height! / 20,
                            width: sizedeta.width! / 4,
                            decoration: BoxDecoration(
                                color: Color(0xff219F94),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            alignment: Alignment.center,
                            child: Text(
                              "Text Size",
                              style: TextStyle(
                                  color: Color(0xffC1DEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
