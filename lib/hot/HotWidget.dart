import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/StateManager/ShareDataInheritedWidget.dart';
import 'package:flutter_doubanmovie/hot/HotMoviesListWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotWidgetState();
  }
}

class HotWidgetState extends State<HotWidget> {

  // 新建变量, 存储当前城市
  // String curCity;

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _initData();
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.red,
          height: 80,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text(ShareDataInheritedWidget.of(context).curCity, style: TextStyle(fontSize: 16)),
                onTap: (){ // 跳转到城市选择页面
                  _jumpToCitysWidget();
                },
              ),
              SizedBox(width: 20,),
              Icon(Icons.search),
              SizedBox(width: 20,),
              Expanded(
                  flex: 1,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: '\uE8b6 电影 / 电视剧 / 影人',
                      hintStyle: TextStyle(fontFamily: 'MaterialIcons', fontSize: 16),
                      contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      filled: true,
                      fillColor: Colors.black12
                    ),
                  )
              )
            ],
          ),
        ),
        Expanded(
        flex: 1,
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                    tabs: [Text('正在热映'), Text('即将上映')],
                    unselectedLabelColor: Colors.black12,
                    labelColor: Colors.black87,
                    indicatorColor: Colors.black87,
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: TabBarView(children: [
                    HotMoviesListWidget(),
                    Center(
                      child: Text('即将上映'),
                    )
                  ]),
                ))
              ],
            ))
        )
      ],
    );
  }

  void _jumpToCitysWidget() async{
    var selectCity = await Navigator.pushNamed(context, '/Citys',arguments: ShareDataInheritedWidget.of(context).curCity);
    if(selectCity == null) return;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('curCity', selectCity); //存取数据

    setState(() {
      ShareDataInheritedWidget.of(context).curCity =  selectCity;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');

  }
}

/*
现在对 HotWidget 进行重构，因为 curCity 现在是存储在 ShareDataInheritedWidget 里，所以把 HotWidget 里的 curCity 变量删掉，
用到 curCity 的地方，用 ShareDataInheritedWidget.of(context).curCity 代替，同时把 curCity 读取的逻辑从 HotWidget 放到 _MyHomePageState 里。
 */