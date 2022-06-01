import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri/data.dart';
import 'package:shayri/second.dart';
import 'package:shayri/sizedata.dart';

class first extends StatefulWidget {
  int pos;
  List templist;
  String colortype;

  first(this.pos, this.templist, this.colortype);

  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  List<Color> currentgradient = data.rgbclr[0];

  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.pos);
  }

  @override
  Widget build(BuildContext context) {
    sizedeta(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff219F94),
        ),
        body: Container(
          color: Color(0xffC1DEAE),
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
                                        currentgradient = data.rgbclr[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: data.rgbclr[index])),
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
                  Text(
                    "   ${widget.pos + 1}/${widget.templist.length}   ",
                    style: TextStyle(fontSize: 25),
                  ),
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
              Container(
                  height: sizedeta.height! / 2.5,
                  width: sizedeta.width! - 50,
                  decoration: BoxDecoration(
                      color: widget.colortype == "singlecolor"
                          ? Colors.purpleAccent
                          : null,
                      gradient: widget.colortype == "gradient"
                          ? LinearGradient(colors: currentgradient)
                          : null,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: PageView.builder(
                    itemCount: widget.templist.length,
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        widget.pos = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(
                          widget.templist[widget.pos],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  )),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          FlutterClipboard.copy(
                                  '${widget.templist[widget.pos]}')
                              .then((value) {
                            Fluttertoast.showToast(
                              msg: "Copied",
                            );
                          });
                        },
                        icon: Icon(Icons.copy)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.pos > 0) {
                              widget.pos = widget.pos - 1;
                              controller!.jumpToPage(widget.pos);
                            }
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return second(
                                widget.templist, widget.pos, "singlecolor");
                          },
                        ));
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.pos < widget.templist.length - 1) {
                              widget.pos = widget.pos + 1;
                              controller!.jumpToPage(widget.pos);
                            }
                          });
                        },
                        icon: Icon(Icons.arrow_forward_ios)),
                    IconButton(
                        onPressed: () {
                          Share.share('${widget.templist[widget.pos]}');
                        },
                        icon: Icon(Icons.share))
                  ],
                ),
              )
            ],
          ),
        ));

  }
}
