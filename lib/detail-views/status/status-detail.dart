import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/models/status/otherStatusModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class StatusDetail extends StatefulWidget {
  final String stat;
  final List<Status> statusList;
  // In the constructor, require a String to update status text
  StatusDetail(this.stat, this.statusList);
  @override
  StatusState createState() => StatusState(stat, statusList);
}

class StatusState extends State<StatusDetail> {
  final String stat;
  final List<Status> statusList;
  StatusState(this.stat, this.statusList);

//Status layout
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: statusList == null ? Container(
        color: Colors.green,
        child: Center(
            child: Container(
          margin: EdgeInsets.all(20),
          child: Text(
            stat,
            style: TextStyle(color: Colors.white, fontSize: 33),
          ),
        )),
      ):_buildSliders(context),
    );
  }

  Widget _buildSliders(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Swiper(
        itemBuilder: (BuildContext context, int i) {
          return Container(
            height: double.infinity,
            child: Container(
              color: Colors.green,
              child: Center(
                  child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  statusList[i].message,
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              )),
            ),
          );
        },
        itemCount: statusList.length,
        layout: SwiperLayout.TINDER,
        itemWidth: screenWidth,
        itemHeight: double.infinity,
        containerHeight: double.infinity,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.white,
                color: Colors.grey,
                size: 5,
                activeSize: 7)));
  }
}
