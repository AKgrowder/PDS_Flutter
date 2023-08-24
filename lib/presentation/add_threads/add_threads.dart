import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_state.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class AddThreadsScreen extends StatefulWidget {
  const AddThreadsScreen({Key? key}) : super(key: key);

  @override
  State<AddThreadsScreen> createState() => _AddThreadsScreenState();
}

enum TextMode {
  normal,
  bold,
  italic,
  lineThrough,
  bullet,

  // link,  <- I'm not sure what you want to have happen with this one
}

bullettext(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "•", // Unicode bullet character
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(width: 8), // Add spacing between bullet and text
      Flexible(
        child: Text(
          " ",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}

const normalStyle = TextStyle();
const boldStyle = TextStyle(fontWeight: FontWeight.bold);
const italicStyle = TextStyle(fontStyle: FontStyle.italic);
const linethrough = TextStyle(decoration: TextDecoration.lineThrough);
bool value = false;

// Helper method

class _AddThreadsScreenState extends State<AddThreadsScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController _RoomTitleController = TextEditingController();
  String description = 'My great package';
  TextMode? currentmode;
  List<String> items = [];
  TextStyle getStyle(TextMode? mode) {
    switch (mode) {
      case TextMode.bold:
        print('datalistCheck-${items}');
        return boldStyle;
      case TextMode.italic:
        return italicStyle;
      case TextMode.lineThrough:
        return linethrough;
      default:
        return normalStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            "Add Thread",
            style: TextStyle(
              fontFamily: 'outfit',
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocProvider<CreatPublicRoomCubit>(
            create: (_) => CreatPublicRoomCubit(),
            child: BlocConsumer<CreatPublicRoomCubit, CreatPublicRoomState>(
                listener: (context, state) async {
              if (state is CreatPublicRoomErrorState) {
                print("error");
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              if (state is CreatPublicRoomLoadingState) {
                print("loading");
                Center(
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
              if (state is CreatPublicRoomLoadedState) {
                print('CreatPublicRoomLoadedState');
                SnackBar snackBar = SnackBar(
                  content: Text(state.PublicRoomData.message ?? ""),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              }
            }, builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Thread",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // MarkdownTextInput(
                  //         (String value) => setState(() => description = value),
                  //         description,insertLinksByDialog: true,
                  //         label: 'Description',
                  //         maxLines: 10,
                  //         actions: MarkdownType.values,
                  //         // controller: controller,
                  //         textStyle: TextStyle(fontSize: 16),
                  //       ),TextButton(
                  //         onPressed: () {
                  //           controller.clear();
                  //         },
                  //         child: Text('Clear'),
                  //       ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => currentmode = TextMode.bold),
                              child: CustomImageView(
                                imagePath: ImageConstant.boldimage,
                                height: 20,
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentmode = TextMode.italic;
                              });
                            },
                            child: CustomImageView(
                              imagePath: ImageConstant.italicimage,
                              height: 15,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentmode = TextMode.lineThrough;
                              });
                            },
                            child: CustomImageView(
                              imagePath: ImageConstant.abimage,
                              height: 30,
                            ),
                          ),
                          Spacer(),
                          CustomImageView(
                            imagePath: ImageConstant.h1image,
                            height: 15,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: doteFunction,
                            child: CustomImageView(
                              imagePath: ImageConstant.lineimage,
                              height: 25,
                            ),
                          ),
                          Spacer(),
                          CustomImageView(
                            imagePath: ImageConstant.imageline,
                            height: 20,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomImageView(
                              imagePath: ImageConstant.pinimage,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                    child: Container(
                      height: 210,
                      // width: width / 1.1,
                      decoration: BoxDecoration(
                        color: Color(0XFFEFEFEF),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: _RoomTitleController,
                                  cursorColor: Colors.grey,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Add Thread....'),
                                  style: TextStyle()
                                      .merge(getStyle(currentmode)))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: GestureDetector(
                      onTap: () {
                        if (_RoomTitleController.text == null ||
                            _RoomTitleController.text == '') {
                          print('condison1');
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Enter Description'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (_RoomTitleController.text.trim().isEmpty ||
                            _RoomTitleController.text.trim() == '') {
                          print('condison1');

                          SnackBar snackBar = SnackBar(
                            content:
                                Text('Description can\'t be just blank spaces'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (_RoomTitleController.text != null ||
                            _RoomTitleController.text != '') {
                          print('condison3');

                          var params = {
                            "roomQuestion": _RoomTitleController.text,
                            "description": _RoomTitleController.text,
                            "roomType": "PUBLIC"
                          };
                          BlocProvider.of<CreatPublicRoomCubit>(context)
                              .CreatPublicRoomAPI(params, context);
                        }
                        // }
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          // width: width / 1.2,
                          decoration: BoxDecoration(
                              color: Color(0XFFED1C25),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Create Forum",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })));
  }

  doteFunction() {
    print('this dsdtasd');
    final testData = ["Example1", "Example2", "Example3", "Example100"];
    value = true;
    final _markDownData =
        testData.map((x) => "- $x\n").reduce((x, y) => "$x$y");
    return Container(
        height: 100,
        width: 100,
        color: Colors.amber,
        margin: EdgeInsets.all(40.0),
        child: Markdown(data: _markDownData));
  }
}

class Demo extends StatelessWidget {
  final testData = ["Example1", "Example2", "Example3", "Example100"];

  @override
  Widget build(BuildContext context) {
    print('halo bayu');
    final _markDownData =
        testData.map((x) => "- $x\n").reduce((x, y) => "$x$y");

    return MaterialApp(
        home: Scaffold(
      body: Container(
          margin: EdgeInsets.all(40.0), child: Markdown(data: _markDownData)),
    ));
  }
}
