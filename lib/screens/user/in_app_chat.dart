import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

class InAppChat extends StatefulWidget {
  const InAppChat({Key? key}) : super(key: key);

  static TextEditingController textController = TextEditingController();

  static GlobalKey sizedKey = GlobalKey();

  @override
  State<InAppChat> createState() => _InAppChatState();
}

class _InAppChatState extends State<InAppChat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  refresh() {
    Future.delayed(Duration(seconds: 30), () {
     //TODO: refresh the chat.
     if(mounted) {
       refresh();
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.parameters["appBarName"].toString()),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: customPurple,
              child: Text(
                "!",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Bubble(
                          alignment: Alignment.center,
                          color: Color.fromRGBO(212, 234, 244, 1.0),
                          child: Text('Yesterday',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0)),
                        ),
                      );
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topRight,
                      //   nip: BubbleNip.rightBottom,
                      //   color: customPurple,
                      //   child: Text('Thanks for adding me',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline3!
                      //           .copyWith(color: Colors.white),
                      //       textAlign: TextAlign.right),
                      // ),
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topLeft,
                      //   nip: BubbleNip.leftBottom,
                      //   color: customLightGrey,
                      //   child: Text('No problem, how can we help'),
                      // ),
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topRight,
                      //   nip: BubbleNip.rightBottom,
                      //   color: customPurple,
                      //   child: Text('I wanted to find out about the fees',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline3!
                      //           .copyWith(color: Colors.white),
                      //       textAlign: TextAlign.right),
                      // ),
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topLeft,
                      //   nip: BubbleNip.leftBottom,
                      //   color: customLightGrey,
                      //   child: Text(
                      //       'Okay cool can you give us an age group you would like to enquire about?'),
                      // ),
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.center,
                      //   nip: BubbleNip.no,
                      //   color: Color.fromRGBO(212, 234, 244, 1.0),
                      //   child: Text('Today',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontSize: 11.0)),
                      // ),
                      // Bubble(
                      //   margin: BubbleEdges.only(top: 10),
                      //   alignment: Alignment.topRight,
                      //   nip: BubbleNip.rightBottom,
                      //   color: customPurple,
                      //   child: Text(
                      //     "Hi sorry got busy, it's for my son he is 8 years old.",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline3!
                      //         .copyWith(color: Colors.white),
                      //   ),
                      // ),;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        key: InAppChat.sizedKey,
                        padding: EdgeInsets.only(left: 20),
                        child: Container(
                          width: mobileWidth - 110,
                          height: 50,
                          child: TextFormField(
                            controller: InAppChat.textController,
                            decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black),
                              fillColor: customLightGrey,
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 20, left: 10),
                          child: CircleAvatar(
                            backgroundColor: customOrange,
                            child: IconButton(
                              onPressed: () async {
                                // if (textController.text.isNotEmpty) {
                                //   setState(() {
                                //     isLoading = true;
                                //   await InsightsController().setComment(
                                //       textController.text.trim(),
                                //       int.parse(insights!));
                                //   setState(() {
                                //     textController.clear();
                                //     isLoading = false;
                                //   });
                                // }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          )
                          // : CircularProgressIndicator(
                          //     color: customOrange,
                          //   ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
