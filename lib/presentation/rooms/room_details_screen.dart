import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Fetchroomdetails_Bloc/Fetchroomdetails_stat.dart';
import 'package:pds/API/Model/fetch_room_detail_model/fetch_room_detail_model.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/commentPdf.dart';

import '../../API/Bloc/Fetchroomdetails_Bloc/Fetchroomdetails_cubit.dart';
import '../../core/utils/color_constant.dart';
import '../../theme/theme_helper.dart';

class RoomDetailScreen extends StatefulWidget {
  String? uuid;
  RoomDetailScreen({Key? key, this.uuid}) : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  FetchRoomDetailModel? fetchRoomDetailModel;

  @override
  void initState() {
    BlocProvider.of<FetchRoomDetailCubit>(context)
        .Fetchroomdetails(widget.uuid.toString(), context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            "Rooms Details",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<FetchRoomDetailCubit, FetchRoomDetailState>(
            listener: (context, state) async {
          if (state is FetchRoomDetailErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is FetchRoomDetailLoadingState) {
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
          if (state is FetchRoomDetailLoadedState) {
            fetchRoomDetailModel = state.fetchRoomDetailModel;

            print(
                "rsetrytrytt rdytsrt ${fetchRoomDetailModel?.object?.companyName}");
          }
        }, builder: (context, state) {
          if (state is FetchRoomDetailLoadingState) {
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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: _height / 9,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE7E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${fetchRoomDetailModel?.object?.createdDate?.split("T")[0]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontFamily: "outfit",
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Text(
                                "${fetchRoomDetailModel?.object?.roomName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Text(
                                "${fetchRoomDetailModel?.object?.roomDescription}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36.0, top: 20),
                  child: Text(
                    "Company Name",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10),
                      child: Text(
                        "${fetchRoomDetailModel?.object?.companyName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36.0, top: 20),
                  child: Text(
                    "Rooms Name",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10),
                      child: Text(
                        "${fetchRoomDetailModel?.object?.roomName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36.0, top: 20),
                  child: Text(
                    "Rooms Description",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10),
                      child: Text(
                        "${fetchRoomDetailModel?.object?.roomDescription}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36.0, top: 20),
                  child: Text(
                    "Document",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DocumentViewScreen(
                                path: fetchRoomDetailModel?.object?.document,
                                title: 'Pdf',
                              )));
                    },
                    child: Container(
                      height: 50,
                      width: _width / 1.2,
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              // color: Colors.amber,
                              width: _width / 1.5,
                              child: Text(
                                "${fetchRoomDetailModel?.object?.document}",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                    fontFamily: "outfit",
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
        }));
  }
}
