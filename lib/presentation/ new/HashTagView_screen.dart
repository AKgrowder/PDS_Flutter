import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

import '../../API/Model/HashTage_Model/HashTagView_model.dart';

class HashTagViewScreen extends StatefulWidget {
  String? title;
  HashTagViewScreen({Key? key, this.title}) : super(key: key);

  @override
  State<HashTagViewScreen> createState() => _HashTagViewScreenState();
}

HashtagViewDataModel? hashTagViewData;

class _HashTagViewScreenState extends State<HashTagViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HashTagCubit>(context)
        .HashTagViewDataAPI(context, widget.title.toString());
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              )),
          title: Row(
            children: [
              Image.asset(
                ImageConstant.hashTagimg,
                height: 45,
                width: 45,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${widget.title}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        body: BlocConsumer<HashTagCubit, HashTagState>(
          listener: (context, state) {
            if (state is HashTagErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is HashTagViewDataLoadedState) {
              hashTagViewData = state.HashTagViewData;
              print("HashTagViewDataLoadedState${hashTagViewData}");
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 20),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: hashTagViewData?.object?.posts?.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        // margin: EdgeInsets.all(10),
                        height: 330,
                        width: _width,
                        decoration: ShapeDecoration(
                          // color: Colors.green,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: ListTile(
                                leading: Container(
                                  width: 48,
                                  height: 52,
                                  margin: EdgeInsets.only(left: 5, top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${hashTagViewData?.object?.posts?[index].userProfilePic}',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                title: Text(
                                  "${hashTagViewData?.object?.posts?[index].postUserName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '8:30 AM',
                                  style: TextStyle(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 12,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Container(
                                    height: 25,
                                    alignment: Alignment.center,
                                    width: 65,
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xffED1C25),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "${hashTagViewData?.object?.posts?[index].description}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImageConstant.likewithout,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontFamily: "outfit", fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Image.asset(
                                    ImageConstant.meesage,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontFamily: "outfit", fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Image.asset(
                                    ImageConstant.vector2,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '1335',
                                    style: TextStyle(
                                        fontFamily: "outfit", fontSize: 14),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(
                                      ImageConstant.savePin,
                                      height: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
