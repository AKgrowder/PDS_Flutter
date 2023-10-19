import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/add_comment_bloc/add_comment_state.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class CommentsScreen extends StatefulWidget {
  String PostUID;

  CommentsScreen({Key? key, required this.PostUID}) : super(key: key);

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
  initState() {
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

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
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
        backgroundColor: theme.colorScheme.onPrimary,
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
          return SingleChildScrollView(
            child: Column(children: [
              Container(
                // color: Colors.amber,
                height: _height / 1.3,
                child: ListView.builder(
                  itemCount: addCommentModeldata?.object?.length,
                  shrinkWrap: true,
                  controller: scroll,
                  itemBuilder: (context, index) {
                    // ListTile( );
                    // DateTime parsedDateTime = DateTime.parse(
                    //     '${addCommentModeldata?.object?[index].createdAt}');

                    // var ara = getTime(parsedDateTime);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: index == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Container(
                                    height: 80,
                                    width: _width / 1.2,
                                    decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(children: [
                                      CustomImageView(
                                        radius: BorderRadius.circular(50),
                                        url:
                                            "${addCommentModeldata?.object?[index].profilePic}",
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 50,
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
                                              Text("1w",
                                                  // customFormat(parsedDateTime),
                                                  style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Container(
                                            width: _width / 1.6,
                                            height: 50,
                                            // color: Colors.amber,
                                            child: Text(
                                                "${addCommentModeldata?.object?[index].comment}",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Container(
                                    height: 80,
                                    width: _width / 1.2,
                                    decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(children: [
                                      addCommentModeldata
                                                  ?.object?[index].profilePic ==
                                              null
                                          ? CustomImageView(
                                              radius: BorderRadius.circular(50),
                                              imagePath: ImageConstant.pdslogo,
                                              fit: BoxFit.fill,
                                              height: 40,
                                              width: 40,
                                            )
                                          : CustomImageView(
                                              radius: BorderRadius.circular(50),
                                              url:
                                                  "${addCommentModeldata?.object?[index].profilePic}",
                                              fit: BoxFit.fill,
                                              height: 40,
                                              width: 40,
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
                                              Text("1w",
                                                  // customFormat(parsedDateTime),
                                                  style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Container(
                                            width: _width / 1.6,
                                            height: 50,
                                            // color: Colors.amber,
                                            child: Text(
                                                "${addCommentModeldata?.object?[index].comment}",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: _width / 1.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
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
                    width: 5,
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
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            ]),
          );
        },
      ),
    );
  }
}
