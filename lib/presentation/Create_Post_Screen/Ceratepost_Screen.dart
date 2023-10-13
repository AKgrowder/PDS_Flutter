import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/example/lib/main.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/lib/photo_gallery.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../core/utils/image_constant.dart';
import 'dart:async';
import 'dart:io';

class CreateNewPost extends StatefulWidget {
  const CreateNewPost({key});

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  int indexx = 0;
  List<Album>? _albums;
  bool _loading = false;
  MediaPage? page;
  Medium? medium1;
  bool selectImage = false;

  @override
  void initState() {
    _loading = true;
    initAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 70,
                      width: _width,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              ImageConstant.Post_Close,
                              height: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.primary_color,
                                borderRadius: BorderRadius.circular(14)),
                            height: 40,
                            width: 70,
                            child: Center(
                                child: Text(
                              "Post",
                              style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                            },
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(ImageConstant.placeholder),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15, left: 10),
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              _showPopupMenu(
                                details.globalPosition,
                                context,
                              );
                            },
                            child: Container(
                              height: 30,
                              width: _width / 2.5,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color: Color(0xffED1C25),
                                  ),
                                  color: ColorConstant.primaryLight_color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Center(
                                      child: Text(
                                        "Public/Followers",
                                        style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 15,
                                          color: ColorConstant.primary_color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 7),
                                    child: Image.asset(
                                      ImageConstant.downarrow,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 15),
                    child: SizedBox(
                      // color: Colors.red[100],
                      // height: _height / 3.5,
                      width: _width,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 80,
                              width: _width,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.0, left: 10),
                                child: TextField(
                                  maxLines: 5,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    hintText: 'What’s on your head?',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              child: selectImage == true
                                  ? medium1?.mediumType == MediumType.image
                                      ? GestureDetector(
                                          onTap: () async {
                                            // PhotoGallery.deleteMedium(
                                            //     mediumId: medium1!.id);
                                          },
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder:
                                                MemoryImage(kTransparentImage),
                                            image: PhotoProvider(
                                                mediumId: medium1!.id),
                                          ),
                                        )
                                      : VideoProvider(
                                          mediumId: medium1!.id,
                                        )
                                  : SizedBox(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 0),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      // margin: EdgeInsets.all(8),
                      height: 90,
                      width: 90,
                      child: Center(
                        child: Container(
                          // margin: EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(255, 0, 0, 0),
                            border: Border.all(
                                color: Color.fromARGB(255, 174, 174, 174),
                                width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Image.asset(
                              ImageConstant.Cameraicon,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: _width - 106,
                      // color: Colors.green,
                      child: _loading
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 100),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(ImageConstant.loader,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100),
                                ),
                              ),
                            )
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                double gridWidth =
                                    (constraints.maxWidth - 20) / 3;
                                double gridHeight = gridWidth + 33;
                                double ratio = gridWidth / gridHeight;
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    // padding: EdgeInsets.all(5),
                                    child: SizedBox(
                                      height: 100,
                                      child: GridView.count(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 10.0,
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          ...page!.items.map(
                                            (medium) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  medium1 = medium;
                                                  selectImage = true;
                                                });
                                                /*  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewerPage(medium),
                                                    ),
                                                  ); */
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: FadeInImage(
                                                    fit: BoxFit.cover,
                                                    placeholder: MemoryImage(
                                                        kTransparentImage),
                                                    image: ThumbnailProvider(
                                                      mediumId: medium.id,
                                                      mediumType:
                                                          medium.mediumType,
                                                      highQuality: true,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void _showPopupMenu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = ["Public", "Following"];
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final selectedOption = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: indexx == index
                          ? Color(0xffED1C25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      ankur[index],
                      style: TextStyle(
                          color: indexx == index ? Colors.white : Colors.black),
                    ),
                  ),
                ))));
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      if (albums.isNotEmpty) {
        page = await albums.first.listMedia();
      }
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        return true;
      }
    }
    return false;
  }
}

class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: date != null ? Text(date.toLocal().toString()) : null,
        ),
        body: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? GestureDetector(
                  onTap: () async {
                    PhotoGallery.deleteMedium(mediumId: medium.id);
                  },
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: PhotoProvider(mediumId: medium.id),
                  ),
                )
              : VideoProvider(
                  mediumId: medium.id,
                ),
        ),
      ),
    );
  }
}
