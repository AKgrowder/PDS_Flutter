import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Model/get_Starred_MessagesModel/get_Starred_Messages.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'dm_new.dart';

class StatrMessage extends StatefulWidget {
  const StatrMessage({Key? key}) : super(key: key);

  @override
  State<StatrMessage> createState() => _StatMessageState();
}

class _StatMessageState extends State<StatrMessage> {
  StaeMessageModel? starMessage;
  @override
  void initState() {
    BlocProvider.of<DmInboxCubit>(context).starMessageApi(context, '1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            height: 30,
            width: 30,
            // color: Colors.red,
            child: Center(
              child: CustomImageView(
                imagePath: ImageConstant.RightArrowgrey,
                height: 25,
                width: 25,
              ),
            ),
          ),
        ),
        title: Text(
          'Starred Message',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<DmInboxCubit, getInboxState>(
        listener: (context, state) {
          if (state is StarMessageGet) {
            starMessage = state.starMessage;
          }
        },
        builder: (context, state) {
          return starMessage?.object == null
              ? Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(ImageConstant.loader,
                          fit: BoxFit.cover, height: 100.0, width: 100),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  itemCount: starMessage?.object?.content?.length,
                  itemBuilder: (context, index) {
                    String? formattedDateString;
                    DateTime? parsedDateTime;
                    if (starMessage?.object?.content?[index].createdAt !=
                            null &&
                        starMessage?.object?.content?[index].createdAt
                                ?.isNotEmpty ==
                            true) {
                      formattedDateString = formatDateString(
                          '${starMessage?.object?.content?[index].createdAt}');
                      parsedDateTime = DateTime.parse(
                          '${starMessage?.object?.content?[index].createdAt}');
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            starMessage?.object?.content?[index]
                                            .userProfilePic !=
                                        null &&
                                    starMessage?.object?.content?[index]
                                            .userProfilePic?.isNotEmpty ==
                                        true
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${starMessage?.object?.content?[index].userProfilePic}'),
                                    radius: 12,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ImageConstant.tomcruse),
                                    radius: 12,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                '${starMessage?.object?.content?[index].userFrom}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Icon(Icons.send, size: 8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '${starMessage?.object?.content?[index].userTo}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "outfit",
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '$formattedDateString',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "outfit",
                              ),
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: width * 0.70),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Card(
                                elevation: 4,
                                color: ColorConstant.otheruserchat,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${starMessage?.object?.content?[index].message}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                          ),
                                        ),
                                      ),
                                      if (starMessage?.object?.content?[index]
                                              .isStarred ==
                                          true)
                                        Image.asset(
                                          ImageConstant.newStar,
                                          height: 15,
                                        ),
                                      if (parsedDateTime != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 3),
                                          child: Text(
                                            customFormat(parsedDateTime),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                                fontFamily: "outfit",
                                                fontSize: 10),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}

String formatDateString(String apiDateString) {
  DateTime apiDateTime = DateTime.parse(apiDateString);
  String formattedDateString = DateFormat('dd/MM/yyyy').format(apiDateTime);
  return formattedDateString;
}
