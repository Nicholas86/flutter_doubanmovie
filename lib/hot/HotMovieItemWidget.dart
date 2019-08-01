import 'package:flutter/material.dart';

import 'package:flutter_doubanmovie/hot/HotMovieData.dart';

class HotMovieItemWidget extends StatefulWidget {

  HotMovieData hotMovieData;

  int index = 0;

  HotMovieItemWidget(this.hotMovieData, this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotMovieItemWidgetState();
  }
}

class HotMovieItemWidgetState extends State<HotMovieItemWidget>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: 160,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.hotMovieData.images.small,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.hotMovieData.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.hotMovieData.rating.average.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text('导演: ' + widget.hotMovieData.directors[0].name,
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                    Text('主演: ' + widget.hotMovieData.casts[0].name + '/' + widget.hotMovieData.casts[1].name,
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              )),
          Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.hotMovieData.rating.max.toString()+'人看过',style: TextStyle(color: Colors.red,fontSize: 14),),
                OutlineButton(
                  child: Text('购票',style: TextStyle(fontSize: 16),),
                  color: Colors.red,
                  textColor: Colors.red,
                  highlightedBorderColor: Colors.red,
                  borderSide: BorderSide(
                      color: Colors.red
                  ),
                  onPressed: () {
                      print("--------${widget.index}");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}