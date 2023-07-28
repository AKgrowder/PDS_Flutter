import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';

class HistoryDetailsScren extends StatefulWidget {
  const HistoryDetailsScren({Key? key}) : super(key: key);

  @override
  State<HistoryDetailsScren> createState() => _HistoryDetailsScrenState();
}

List<String> payment = [
  "Payment Status",
  "Payment Time",
  "Transaction ID",
  "Payment Method ",
  "Transfer Charges ",
  "Amount",
];
List<String> status = [
  "Success",
  "4th Feb. 2023  0:00 pm",
  "#123456",
  "2",
  "UPI - GPAY",
  "16,000",
];

class _HistoryDetailsScrenState extends State<HistoryDetailsScren> {
  @override
  Widget build(BuildContext context) {
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
          "History",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 20, left: 20),
          child: Container(
            height: height / 6.5,
            width: width / 1.1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "06/06/2023, 00:00",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          maxRadius: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ongoing",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Company Name",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Room Name",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Expert user ID",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Address specific packaging challenges....",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // color: Colors.amber,
                height: 300,
                width: width / 3,
                child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [SizedBox(height: 35,),
                        Text(
                          payment[index],
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                // color: Colors.amber,
                height: 300,
                width: width / 2.5,
                child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [SizedBox(height: 35,),
                        Text(
                          status[index],
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color:index==0? Colors.green:Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
        // Row(
        //   children: [
        //     Container(
        //       color: Colors.amber,
        //       height: height / 2,
        //       width: 150,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text("Payment Status"),
        //           Text("Payment Time"),
        //           Text("Transaction ID"),
        //           Text("Payment Method"),
        //           Text("Transfer Charges"),
        //           Text("Amount")
        //         ],
        //       ),
        //     ),
        //     Container(
        //       color: Colors.amber,
        //       height: height / 2,
        //       width: 150,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text("Payment Status"),
        //           Text("Payment Time"),
        //           Text("Transaction ID"),
        //           Text("Payment Method"),
        //           Text("Transfer Charges"),
        //           Text("Amount")
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ]),
    );
  }
}
