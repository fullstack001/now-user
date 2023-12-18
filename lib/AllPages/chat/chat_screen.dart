import 'package:application_1/All_Refrences/shared_refrence.dart';
// import 'package:application_1/keyboard_overlay/keyboard_overlay.dart';
import 'package:application_1/model/chat/user_chat.dart';
import 'package:application_1/model/chat/user_chat_data.dart';
import 'package:application_1/model/chat/user_chat_list_data.dart';
import 'package:application_1/model/chat/user_chat_response.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:laravel_echo/laravel_echo.dart';
import '../../utils/widgest_utills.dart';
import 'chatt_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  @required
  final senderId;
  @required
  final receiverId;
  final onUpdate;
  @required
  final name;
  final image;
  final orderId;
  final isComplete;

  ChatScreen({
    Key? key,
    this.receiverId,
    this.senderId,
    this.onUpdate,
    this.name,
    this.orderId,
    this.isComplete,
    this.image,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageController = TextEditingController();
  ChatController _chatController = Get.find();
  int line = 75;
  // var keyboardVisibilityController = KeyboardVisibilityController();
  ScrollController _controller = ScrollController();

  var messageNode = FocusNode();

  List<UserChat> chatList = [];
  bool loading = false;
  bool hasFocus = false;

  @override
  void initState() {
    // if (GetPlatform.isIOS) {
    //   messageNode = GetFocusNodeOverlay(
    //       child: TopKeyboardUtil(
    //     DoneButtonIos(
    //       label: 'Done',
    //       onSubmitted: () => Get.focusScope!.unfocus(),
    //       platforms: ['android', 'ios'],
    //     ),
    //   ));
    // }
    super.initState();

    try {
      _chatController.fetchUserChat(
          id: widget.receiverId,
          orderId: widget.orderId,
          update: () {
            setState(() {});
          });
// Create echo instance
      chatOpen = true;
      setPagination();
      Echo echo = Echo({
        'broadcaster': 'socket.io',
        'client': IO.io,
        "host": 'https://api.farenow.com',
      });
      echo.socket.on('connect', (_) {
        print('connected');
      });
      // Listening public channel
      echo
          .channel('newMessage-${widget.senderId}-${widget.receiverId}')
          .listen('MessageEvent', (e) {
        print(e);
        _chatController.fetchUserChat(
            id: widget.receiverId,
            orderId: widget.orderId,
            update: () {
              setState(() {});
            });
      });

      // Create ech
      Echo echo1 = Echo({
        'broadcaster': 'socket.io',
        'client': IO.io,
        "host": 'https://api.farenow.com',
      });

      echo1.socket.on('connect', (_) {
        print('connected');
      });

// Listening public channel
      echo1
          .channel('newMessage-${widget.receiverId}-${widget.senderId}')
          .listen('MessageEvent', (e) {
        print(e);
        _chatController.fetchUserChat(
            id: widget.receiverId,
            orderId: widget.orderId,
            update: () {
              setState(() {});
            });
      });
    } catch (e) {
      print(e);
    }

    // if (GetPlatform.isIOS) {
    //   keyboardVisibilityController.onChange.listen((bool visible) {
    //     print('Keyboard visibility update. Is visible: $visible');
    //     hasFocus = !hasFocus;
    //     setState(() {});
    //   });
    // }
  }

  List userChatListData = [];

  @override
  Widget build(BuildContext context) {
    // line = 45;
    // chatList = chatList.reversed.toList();

    if (_chatController.chatData.value.userChatData != null) {
      userChatListData = checkMessages();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            // widget.image == null
            //     ? Container()
            //     :
            // Container(
            //   width: 50,
            //   height: 50,
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: 48,
            //         height: 48,
            //         child: cacheNetworkImage(
            //             imageUrl: "${ApiUtills.imageBaseUrl + widget.image}",
            //             placeHolder: 'assets/user_assets/png/user.png',
            //             imageHeight: 50,
            //             imageWidth: 50,
            //             radius: 100),
            //       ),
            //       Align(
            //         alignment: Alignment.bottomRight,
            //         child: Container(
            //           decoration:
            //               BoxDecoration(shape: BoxShape.circle, color: white),
            //           padding: EdgeInsets.all(2),
            //           child: Container(
            //               margin: EdgeInsets.only(bottom: 2, right: 2),
            //               width: 12,
            //               height: 12,
            //               decoration: BoxDecoration(
            //                   shape: BoxShape.circle, color: greenColor)),
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            Text(
              widget.name ?? "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            chatOpen = false;
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: WillPopScope(
        onWillPop: () async {
          chatOpen = false;
          return true;
        },
        child: Column(
          children: [
            Expanded(
                child: Obx(() => ((_chatController
                                        .chatData.value.userChatData ??
                                    UserChatData())
                                .userChatListData ??
                            [])
                        .isEmpty
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: ListView.builder(
                          controller: _controller,
                          reverse: true,
                          itemCount: (userChatListData).length,
                          itemBuilder: (BuildContext context, int index) {
                            // int index = (userChatListData.length - 1) - ind;
                            UserChatListData value = userChatListData[index];
                            userChatListData = _chatController
                                .chatData.value.userChatData.userChatListData;

                            return loading &&
                                    index == userChatListData.length - 1
                                ? Container(
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  )
                                : chatBubbles(value, index);
                          },
                        ),
                      ))),
            if ((widget.isComplete ?? 0) != 1)
              CustomContainer(
                  width: Get.width,
                  height: line < 140 ? line : 140,
                  color: AppColors.solidBlue,
                  allRadius: 0,
                  marginLeft: 0,
                  marginRight: 0,
                  marginBottom: 0,
                  paddingLeft: 12,
                  paddingRight: 12,
                  paddingTop: 4,
                  paddingBottom: 4,
                  // paddingAll: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/user_assets/svg/gallery-add_sheet.svg",
                            color: white,
                            width: 33,
                            height: 33,
                          ),
                        ),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextField(
                              focusNode: messageNode,
                              controller: messageController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              textInputAction: TextInputAction.newline,
                              onChanged: (val) {
                                print(val.length);
                                print(val);
                                int count = val.split("\n").length;
                                if (count > 1) {
                                  count = count - 1;
                                  print("$count");
                                  line = 75 + (25 * count);
                                } else {
                                  line = 75;
                                }
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  fillColor: white,
                                  filled: true,
                                  hintText: "Type a message",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: redColor)),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: white))),
                            ),
                          )),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: InkWell(
                            onTap: () {
                              if (messageController.text.isEmpty) {
                                return;
                              }
                              Map _body = <String, dynamic>{
                                "receiver_id": widget.receiverId.toString(),
                                "message": messageController.text,
                                "service_request_id": widget.orderId.toString()
                              };
                              UserChatListData data = UserChatListData(
                                  senderId: widget.senderId,
                                  receiverId: widget.receiverId,
                                  message: messageController.text);
                              if (userChatListData.isNotEmpty) {
                                userChatListData.insert(0, data);
                              } else {
                                userChatListData.add(data);
                              }
                              UserChat userChat = UserChat(
                                  message: messageController.text.toString(),
                                  time: DateTime.now());
                              chatList.add(userChat);
                              messageController.text = "";
                              line = 75;

                              // UserChatListData value = userChatListData[index];

                              setState(() {});

                              _chatController.sendMessage(_body,
                                  onUpdate: widget.onUpdate == null
                                      ? () {
                                          setState(() {});
                                        }
                                      : widget.onUpdate);
                            },
                            child: SvgPicture.asset(
                                "assets/user_assets/svg/send.svg")),
                      )
                    ],
                  )),
            if (hasFocus)
              SizedBox(
                height: 40,
              ),
          ],
        ),
      ),
    );
  }

  String getTime(String time) {
    DateTime dateTime = DateTimeUtils().convertStringWoT(time);
    String convertedTime = DateTimeUtils().parseDateTime(dateTime, "hh:mm aa");
    return convertedTime;
  }

  void setPagination() {
    _controller.addListener(() async {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        if (_chatController.chatData.value.userChatData.nextPageUrl != null) {
          loading = true;
          setState(() {});
          String page = _chatController.chatData.value.userChatData.nextPageUrl
              .split("page=")[1];

          ServiceReposiotry _repo = ServiceReposiotry();
          String authToken =
              await SharedRefrence().getString(key: ApiUtills.authToken);
          await _repo
              .getUserChat(
                  authToken: authToken, id: widget.receiverId, page: page)
              .then((UserChatResponse? response) {
            if (response != null) {
              _chatController.chatData.value.userChatData.nextPageUrl =
                  response.userChatData.nextPageUrl;
              _chatController.chatData.value.userChatData.userChatListData
                  .addAll(response.userChatData.userChatListData);

              loading = false;
              setState(() {});
            }
          });
        }
      }
    });
  }

  checkSender(UserChatListData value) {
    if (value.senderId.toString() == widget.receiverId) {
      return true;
    }
    return false;
  }

  // Widget chatBubble(UserChatListData value, index) {
  //   return ChatBubble(
  //     clipper: ChatBubbleClipper4(
  //         type: checkSender(value)
  //             ? BubbleType.receiverBubble
  //             : BubbleType.sendBubble),
  //     alignment: checkSender(value) ? Alignment.topLeft : Alignment.topRight,
  //     margin: EdgeInsets.only(
  //         top: index == userChatListData.length - 1 ? 12 : 6,
  //         bottom: index == 0 ? 12 : 0),
  //     backGroundColor: Colors.white,
  //     child: Container(
  //       constraints: BoxConstraints(
  //         maxWidth: MediaQuery.of(context).size.width * 0.7,
  //       ),
  //       child: Stack(
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(top: 0),
  //             child: Column(
  //               children: [
  //                 RichText(
  //                   text: TextSpan(
  //                     children: <TextSpan>[
  //                       //real message
  //                       TextSpan(
  //                         text: getMessage(value),
  //                         style: Theme.of(context).textTheme.subtitle1,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 14,
  //                 )
  //               ],
  //             ),
  //           ),

  //           //real additionalInfo
  //           Positioned(
  //             child: Container(
  //               child: value.createdAt != null
  //                   ? RichText(
  //                       text: TextSpan(
  //                         children: <TextSpan>[
  //                           //real message
  //                           TextSpan(
  //                             text: getTime(value.createdAt),
  //                             style:
  //                                 TextStyle(fontSize: 12, color: Colors.grey),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   : SvgPicture.asset(
  //                       'assets/ic_time.svg',
  //                       width: 16,
  //                       color: Colors.grey,
  //                     ),
  //             ),
  //             right: 0.0,
  //             bottom: 0.0,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  getMessage(UserChatListData value) {
    String whiteSpaces = "";
    int size = int.parse(
        (value.message.length < 18 ? (18 - value.message.length) : 0)
            .toString());
    for (int index = 0; index < size; index++) {
      whiteSpaces = whiteSpaces + " ";
    }

    String finalString = value.message + whiteSpaces;
    //"${value.message}" + "                 "
    return finalString;
  }

  List checkMessages() {
    var remoteMessages =
        _chatController.chatData.value.userChatData.userChatListData;
    //  21                    <   22
    if (remoteMessages.length < userChatListData.length) {
      print("if condition");
      int size =
          _chatController.chatData.value.userChatData.userChatListData.length;
      for (int index = size; index < userChatListData.length; index++) {
        // remoteMessages.insert(0, userChatListData[index]);
      }
    }
    userChatListData = remoteMessages;
    return userChatListData;
  }

  Widget chatBubbles(UserChatListData value, index) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: checkSender(value)
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            value.senderDetail != null
                ? checkSender(value)
                    ? value.senderDetail.image != null
                        ? Flexible(
                            child: FittedBox(
                              child: cacheNetworkImage(
                                  imageWidth: 40,
                                  imageHeight: 40,
                                  radius: 90,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${ApiUtills.imageBaseUrl + value.senderDetail.image}"),
                            ),
                          )
                        : const FittedBox(
                            child: Image(
                            image:
                                AssetImage("assets/user_assets/png/user.png"),
                            width: 40,
                            height: 40,
                          ))
                    : Container()
                : Container(),
            5.width,
            Card(
              color: Color(0xffE0E0E0),
              shape: RoundedRectangleBorder(
                  borderRadius: checkSender(value)
                      ? const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      value.createdAt != null
                          ? RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  //real message
                                  TextSpan(
                                    text: getTime(value.createdAt),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff757575),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/ic_time.svg',
                              width: 16,
                              color: Colors.grey,
                            ),
                      Container(
                        width: Get.width * 0.6,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              //real message
                              TextSpan(
                                text: getMessage(value),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            5.width,
            value.senderDetail != null
                ? !checkSender(value)
                    ? value.senderDetail.image != null
                        ? cacheNetworkImage(
                            imageWidth: 45,
                            imageHeight: 45,
                            radius: 90,
                            fit: BoxFit.cover,
                            imageUrl:
                                "${ApiUtills.imageBaseUrl + value.senderDetail.image}")
                        : const FittedBox(
                            child: Image(
                            image:
                                AssetImage("assets/user_assets/png/user.png"),
                            width: 40,
                            height: 40,
                          ))
                    : Container()
                : Container()
          ],
        ));
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 4),
    //   child: ChatBubble(
    //     clipper: ChatBubbleClipper4(
    //         type: checkSender(value)
    //             ? BubbleType.receiverBubble
    //             : BubbleType.sendBubble),
    //     alignment: checkSender(value) ? Alignment.topLeft : Alignment.topRight,
    //     margin: EdgeInsets.only(
    //         top:
    //             index == double.parse((userChatListData!.length - 1).toString())
    //                 ? 12
    //                 : 6,
    //         bottom: index == 0 ? 12 : 0),
    //     backGroundColor: Colors.white,
    //     child: Container(
    //       constraints: BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width * 0.55,
    //       ),
    //       child: Stack(
    //         children: <Widget>[
    //           Positioned(
    //             child: Container(
    //               alignment: Alignment.centerLeft,
    // child: value.createdAt != null
    //     ? RichText(
    //         text: TextSpan(
    //           children: <TextSpan>[
    //             //real message
    //             TextSpan(
    //               text: getTime(value.createdAt),
    //               style: const TextStyle(
    //                   fontSize: 12, color: Colors.grey),
    //             ),
    //           ],
    //         ),
    //       )
    //     : SvgPicture.asset(
    //         'assets/ic_time.svg',
    //         width: 16,
    //         color: Colors.grey,
    //       ),
    //             ),
    //           ),

    //           Padding(
    //             padding: const EdgeInsets.only(top: 22),
    //             child: Column(
    //               children: [
    //                 RichText(
    //                   text: TextSpan(
    //                     children: <TextSpan>[
    //                       //real message
    //                       TextSpan(
    //                         text: getMessage(value),
    //                         style: Theme.of(context).textTheme.subtitle1,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 14,
    //                 )
    //               ],
    //             ),
    //           ),

    //           //real additionalInfo
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
