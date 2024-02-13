import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/ReadAll_Bloc/ReadAll_state.dart';
import 'package:pds/core/utils/color_constant.dart';

import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../../API/Bloc/ReadAll_Bloc/ReadAll_cubit.dart';

class ReadAlldailog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReadAlldailogState();
}

class ReadAlldailogState extends State<ReadAlldailog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            // height: height / 1.4,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 BlocConsumer<ReadAllMSGCubit, ReadAllMSGState>(listener: (context, state) {
                      if (state is ReadAllMSGErrorState) {
             
               
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                
              }
              if(state is ReadAllMSGLoadedState){
                Navigator.pop(context);
                BlocProvider.of<InvitationCubit>(context).AllNotification(context);
              }
                 },builder: (context, state) {
                   return  AlertDialog(
                      title: const Text(
                        'Read All',
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        'Are You Sure Read All Your Massages?',
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorConstant.primary_color,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(),
                                  child: const Text('Okay',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
                                     BlocProvider.of<ReadAllMSGCubit>(context)
                                        .ReadAllMassagesAPI(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                 },)
                    
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
