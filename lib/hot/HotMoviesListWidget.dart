import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/StateManager/ShareDataInheritedWidget.dart';
import 'package:flutter_doubanmovie/hot/HotMovieItemWidget.dart';
import 'package:flutter_doubanmovie/hot/HotMovieData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotMoviesListWidget extends StatefulWidget {

//  // 城市
//  String curCity;
//  HotMoviesListWidget(String city) {
//    curCity = city;
//  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> {

  /*
  优化:
    在加了刷新界面后，发现 TabBar 每次切换，Widget 都会重新加载，会重新请求数据，是因为 DefaultTabController 在切换 Widget 的时候，为了回收内存，
    会将不显示的 Widget 回收掉，但是这个不是我们想见到的，我们要切换 Widget 的时候，不会回收不显示的 Widget，
    这就需要让 HotMoviesListWidgetState mixin AutomaticKeepAliveClientMixin。
   */
  bool get wantKeepAlive => true; //返回 true，表示不会被回收

  List<HotMovieData> hotMovies = new List<HotMovieData>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (hotMovies == null || hotMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.separated(
        itemCount: hotMovies.length,
        itemBuilder: (context, index) {
          return HotMovieItemWidget(hotMovies[index], index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black26,
            height: 1,
          );
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('---- didChangeDependencies');
    /// 请求数据
    _getData();
  }

  /// 请求数据
  void _getData() async {
    List<HotMovieData> movies = new List();
    String curCity = ShareDataInheritedWidget.of(context).curCity;
    var response = await http.get(
      'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city='+curCity+'&start=0&count=10&client=&udid='
    );
    
    print('Response status: ${response.statusCode}');
    print('didChangeDependencies');

    if (response.statusCode == 200) {
      print(response.body);
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
          HotMovieData movie = HotMovieData.fromJson(data);
          movies.add(movie);
      }

      setState(() {
        hotMovies = movies;
      });
    }
  }

}

/*

因为 _getData() 里的 ShareDataInheritedWidget.of(context).curCity 用到了 context，
所以 _getData() 不能放在 initState() 里调用，因为在 initState() 里 context 还不能使用，所以要重构成：
 */

/*
didChangeDependencies() 方法会在它依赖的数据发生变化的时候调用，
而这里 HotMoviesListWidget 依赖的数据就是其父 Widget ShareDataInheritedWidget 的数据，
didChangeDependencies() 调用的条件就是 ShareDataInheritedWidget 的 updateShouldNotify() 方法返回 true。
 */