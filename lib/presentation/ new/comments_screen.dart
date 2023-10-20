import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/add_comment_bloc/add_comment_state.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../register_create_account_screen/register_create_account_screen.dart';

class CommentsScreen extends StatefulWidget {
  String PostUID;
  String? image;
  String? userName;
  String? description;
  String? date;

  CommentsScreen(
      {Key? key,
      required this.PostUID,
      this.image,
      this.userName,
      this.description,this.date})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  AddCommentModel? addCommentModeldata;
  final TextEditingController addcomment = TextEditingController();
  final ScrollController scroll = ScrollController();
  String? User_ID;
  savedataFunction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    setState(() {});
  }

  @override
  void initState() {
    savedataFunction();
    print("PostUID-->${widget.PostUID}");
    BlocProvider.of<AddcommentCubit>(context)
        .Addcomment(context, widget.PostUID);
    super.initState();
  }

  void _goToElement() {
    scroll.animateTo((1000 * 20),
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'st January';
      case 2:
        return 'nd February';
      case 3:
        return 'rd March';
      case 4:
        return 'th April';
      case 5:
        return 'th May';
      case 6:
        return 'th June';
      case 7:
        return 'th July';
      case 8:
        return 'th August';
      case 9:
        return 'th September';
      case 10:
        return 'th October';
      case 11:
        return 'th November';
      case 12:
        return 'th December';
      default:
        return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.colorScheme.onPrimary,

      // appBar: CustomAppBar(
      //   height: 100,
      //   title: Row(
      //     children: [
      //       SizedBox(
      //         width: _width / 4,
      //       ),
      //       Text(
      //         "Commnents",
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontFamily: 'Outfit',
      //             fontWeight: FontWeight.w600,
      //             fontSize: 20),
      //       ),
      //     ],
      //   ),
      //   leadingWidth: 74,
      //   leading: Column(
      //     children: [
      //       Container(
      //         height: 44,
      //         width: 44,
      //         margin: EdgeInsets.only(left: 30, top: 6, bottom: 6),
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 0, right: 20),
      //             child: Icon(
      //               Icons.arrow_back,
      //               color: Theme.of(context).brightness == Brightness.light
      //                   ? Color(0XFF989898)
      //                   : Color(0xFFC5C0C0),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Comments",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: BlocConsumer<AddcommentCubit, AddCommentState>(
        listener: (context, state) async {
          if (state is AddCommentLoadedState) {
            addCommentModeldata = state.commentdata;
          }

          if (state is AddCommentErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is AddnewCommentLoadedState) {
            addcomment.clear();
            Object object =
                Object.fromJson(state.addnewCommentsModeldata['object']);

            addCommentModeldata?.object?.add(object);
            print(
                "cghfdgfgghgh->${addCommentModeldata?.object?.last.runtimeType}");
            _goToElement();
          }
        },
        builder: (context, state) {
          if (state is AddCommentLoadingState) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      // color: Colors.amber,
                      height: _height / 1.5,
                      child: ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        itemCount: addCommentModeldata?.object?.length,
                        shrinkWrap: true,
                        controller: scroll,
                        itemBuilder: (context, index) {
                          DateTime parsedDateTime = DateTime.parse(
                                      '${addCommentModeldata?.object?[index]. createdAt ?? ""}');
                          // ListTile( );
                          // DateTime parsedDateTime = DateTime.parse(
                          //     '${addCommentModeldata?.object?[index].createdAt}');

                          // var ara = getTime(parsedDateTime);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:15.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Container(
                                    // height: 80,
                                    // width: _width / 1.2,
                                    decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      addCommentModeldata
                                                  ?.object?[index].profilePic ==
                                              null
                                          ? CustomImageView(
                                              radius: BorderRadius.circular(50),
                                              imagePath: ImageConstant.pdslogo,
                                              fit: BoxFit.fill,
                                              height: 35,
                                              width: 35,
                                            )
                                          : CustomImageView(
                                              radius: BorderRadius.circular(50),
                                              url:
                                                  "${addCommentModeldata?.object?[index].profilePic}",
                                              fit: BoxFit.fill,
                                              height: 35,
                                              width: 35,
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${addCommentModeldata?.object?[index].userName}",
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                // "1w",
                                                  customFormat(parsedDateTime),
                                                  style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Container(
                                            width:_width /1.4,
                                            // height: 50,
                                            // color: Colors.amber,
                                            child: Text(
                                                "${addCommentModeldata?.object?[index].comment}",
                                                // maxLines: 2,
                                            
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    overflow:
                                                        TextOverflow.visible,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: _width / 1.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              controller: addcomment,
                              cursorColor: ColorConstant.primary_color,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Add Comment",
                                  icon: Icon(
                                    Icons.emoji_emotions_outlined,
                                    color: Colors.grey,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (User_ID == null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterCreateAccountScreen()));
                            } else if (addcomment.text == null ||
                                addcomment.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Add Comment'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Map<String, dynamic> params = {
                                "comment": addcomment.text,
                                "postUid": widget.PostUID,
                              };

                              BlocProvider.of<AddcommentCubit>(context)
                                  .AddPostApiCalling(context, params);
                            }
                          },
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: ColorConstant.primary_color,
                            child: Center(
                              child: Image.asset(
                                ImageConstant.commentarrow,
                                height: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  height: 80,
                  width: _width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomImageView(
                      radius: BorderRadius.circular(50),
                      url: widget.image,
                      fit: BoxFit.fill,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.userName ?? "",
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1w",
                                // customFormat(parsedDateTime),
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13, 
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Container(
                          width: _width / 1.6,
                          // height: 50,
                          // color: Colors.amber,
                          child: Text(
                            widget.description ?? "",
                       
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ]),
                ),
              ),
            ],
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
  
}
