import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
 
 
// ignore: must_be_immutable
class Policies extends StatefulWidget {
  String? data;
  String? title;
  Policies({Key? key, this.data, this.title}) : super(key: key);
  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: CustomAppBar(
          height: 84,
          leadingWidth: 74,
          leading: Container(
            height: 44,
            width:44,
            margin: EdgeInsets.only(left: 30, top: 6, bottom: 6),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                   padding: const EdgeInsets.only(top:16),
                   child: Stack(
                     children: [Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            // color: const Color(0XFFF6F6F6),
                            color: Theme.of(context).brightness == Brightness.light
                             ? Color(0XFFEFEFEF)
                             : Color(0XFF212121),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:   Icon(
                            Icons.arrow_back,color: Theme.of(context).brightness == Brightness.light
                             ? Color(0XFF989898)
                             : Color(0xFFC5C0C0),
                            
                          ),
                        ),], 
                   ),
                 ),
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.title ?? '',textScaleFactor: 1.0,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                // color: ColorConstant.black900
                color:   Theme.of(context).brightness == Brightness.light
                           ? Colors.black
                           : Colors.white,
                ),
          )),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: HtmlWidget(widget.data ?? ''

              // tagsList: Html.tags,
              // style: {
              //   "table": Style(
              //     backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
              //   ),
              //   "tr": Style(
              //     border: Border(bottom: BorderSide(color: Colors.grey)),
              //   ),
              //   "th": Style(
              //     padding: EdgeInsets.all(6),
              //     backgroundColor: Colors.grey,
              //   ),
              //   "td": Style(
              //     padding: EdgeInsets.all(6),
              //     alignment: Alignment.topLeft,
              //   ),
              //   'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
              // },
              ),
        ),
      ), /* Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: height / 30,
        ),
        customPrivacyContainer(
            image: ImageConstant.TermsOfUse,
            name: "Terms Of Use",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsConditionScreen(
                            pdfImage: ImageConstant.termsConditionPDF,
                          )));
            }),
        customPrivacyContainer(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsConditionScreen(
                            pdfImage: ImageConstant.privcyPolicyPDF,
                          )));
            },
            image: ImageConstant.PrivacyPolicy,
            name: "Privacy Policy"),
        customPrivacyContainer(image: ImageConstant.AboutUs, name: "About Us"),
        customPrivacyContainer(
            image: ImageConstant.Disclaimar, name: "Disclaimer"),
      ]), */
    );
  }

  Widget customPrivacyContainer(
      {required String name, required String image, void Function()? onTap}) {
            double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: _height / 15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFEFEFEF),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _width / 20,
              ),
              Image.asset(
                image,
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: _width / 20,
              ),
              Text(
                name,textScaleFactor: 1.0,
                style: TextStyle(
                    color: Color(0xFF939393),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xFF939393),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
