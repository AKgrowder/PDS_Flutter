import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/SelectRoom_Bloc/SelectRoom_cubit.dart';
import '../../API/Bloc/SelectRoom_Bloc/SelectRoom_state.dart';
import '../../API/Model/SelectRoomModel/SelectRoom_Model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class RoomSelection extends StatefulWidget {
  String? ExperID;
  RoomSelection({required this.ExperID});

  @override
  State<RoomSelection> createState() => _RoomSelectionState();
}

SelectRoomModel? SelectedRoomData;
int? selectedIndex = -1;
String? RoomID;

class _RoomSelectionState extends State<RoomSelection> {
  @override
  void initState() {
    GetStatus();
    BlocProvider.of<SelectedRoomCubit>(context).SelectedRoomApi(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    selectedIndex = -1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocConsumer<SelectedRoomCubit, SelectedRoomState>(
        listener: (context, state) {
      if (state is SelectedRoomLoadingState) {
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
      if (state is SherInvite2LoadedState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.sherInvite.message ?? ""),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(milliseconds: 900), () {
          Navigator.pop(context);
        });
      }
      if (state is SelectedRoomErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // if (state is fetchUserModulemodelLoadedState) {
      //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" +
      //       "${state.fetchUserModule.object}");
      //   user_Module = state.fetchUserModule.object?.userModule ?? "";
      //   User_profile = state.fetchUserModule.object?.userProfilePic ?? "";
      // }
      if (state is SelectedRoomLoadedState) {
        print("uuuuuuuuuuuuuuuuuuuuuuuuuu");
        print(state.SelectedRoom.object?[0]);
        SelectedRoomData = state.SelectedRoom;
        print(SelectedRoomData?.object?.length);
        setState(() {});
      }
    }, builder: (context, state) {
      return SafeArea(
          child: Scaffold(
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.onPrimary,
          title: Text(
            "Select Rooms",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: Container(
          // color: Colors.red[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectedRoomData?.object?.length == 0 ||
                      SelectedRoomData?.object == null ? Spacer() : SizedBox(),
              SelectedRoomData?.object?.length == 0 ||
                      SelectedRoomData?.object == null
                  ? Center(
                      child: Container(
                        height: 400,
                        width: 250,
                        child: CustomImageView(
                          imagePath: ImageConstant.noRoom,
                          fit: BoxFit.fill,
                        ),
                        // color: Colors.red,
                      ),
                    )
                  : Container(
                      height: _height / 1.3,
                      // color: Colors.green[100],
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: SelectedRoomData?.object?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return SelectedRoomData
                                      ?.object?[index].isExpertPresent ==
                                  true
                              ? Container(
                                  height: 0,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      RoomID =
                                          SelectedRoomData?.object?[index].uid;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Container(
                                        height: 65,
                                        decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? Color(0xFFFFE7E7)
                                                : Colors.white,
                                            border: Border.all(
                                                color: ColorConstant.primary_color,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                                left: 15,
                                              ),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${SelectedRoomData?.object?[index].roomQuestion}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 15),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${SelectedRoomData?.object?[index].description}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Center(child: Text('Entry ${entries[index]}')),
                                        ),
                                  ),
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SelectedRoomData?.object?[index].isExpertPresent ==
                                    true
                                ? SizedBox()
                                : Divider(),
                      ),
                    ),
              Spacer(),
              selectedIndex != -1
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 16, right: 16, bottom: 25),
                      child: Container(
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            print(widget.ExperID);
                            print(RoomID);
                            BlocProvider.of<SelectedRoomCubit>(context)
                                .sherInviteApi2(RoomID.toString(),
                                    widget.ExperID.toString(), context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // margin: EdgeInsets.only(top: 15),
                            // height: 50,
                            width: _width,
                            decoration: BoxDecoration(
                                color: ColorConstant.primary_color,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ));
    });

    /*  return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.red[200],
      ),
    )); */
  }

  GetStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserStatus = prefs.getString(PreferencesKey.userStatus);
    var UserModule = prefs.getString(PreferencesKey.module);
  }
}
