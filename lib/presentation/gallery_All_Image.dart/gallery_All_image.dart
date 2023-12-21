// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Model/GetAllInboxImagesModel/GetAllInboxImagesModel.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/widgets/animatedwiget.dart';
import 'package:pds/widgets/pagenation.dart';

class GalleryImage extends StatefulWidget {
  String? userChatInboxUid;
  GalleryImage({this.userChatInboxUid});
  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  GetAllInboxImages? getAllInboxImages;
  bool apidataGet = false;
  bool dataSetintial = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<DmInboxCubit>(context)
        .GetAllInboxImagesApi(context, widget.userChatInboxUid.toString(), '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.all(10),
                child: Image.asset(ImageConstant.backArrow))),
        title: Text(
          'Image',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<DmInboxCubit, getInboxState>(
        listener: (context, state) {
          if (state is GetAllInboxImagesState) {
            getAllInboxImages = state.getAllInboxImages;
            if (getAllInboxImages?.object?.content?.isNotEmpty == true) {
              apidataGet = true;
            } else {
              apidataGet = false;
              dataSetintial = true;
            }
          }
          if (state is getInboxErrorState) {
            apidataGet = false;
            dataSetintial = false;
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return apidataGet == false
              ? dataSetintial == true
                  ? Center(
                      child: Text(
                        "No Record Found",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : Center(
                      child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(ImageConstant.loader,
                            fit: BoxFit.cover, height: 100.0, width: 100),
                      ),
                    ))
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: PaginationWidget(
                          scrollController: scrollController,
                          totalSize: getAllInboxImages?.object?.totalElements,
                          offSet:
                              getAllInboxImages?.object?.pageable?.pageNumber,
                          onPagination: (p0) async {
                            BlocProvider.of<DmInboxCubit>(context)
                                .GetAllInboxImagesPagantionApi(
                                    context,
                                    widget.userChatInboxUid.toString(),
                                    '${(p0 + 1)}');
                          },
                          items: GridView.builder(
                            
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, 
                              crossAxisSpacing: 8.0, 
                              mainAxisSpacing: 8.0, 
                            ),
                            itemCount: getAllInboxImages?.object?.content
                                ?.length, // Number of items in the grid
                            itemBuilder: (BuildContext context, int index) {
                              // Your grid item widget goes here
                              return GridTile(
                                child: Container(
                                    // color: Colors.blue,
                                    child: AnimatedNetworkImage(
                                        imageUrl:
                                            "${getAllInboxImages?.object?.content?[index]}")),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
