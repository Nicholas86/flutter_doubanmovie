import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/hot/HotWidget.dart';
import 'package:flutter_doubanmovie/mine/MineWidget.dart';
import 'package:flutter_doubanmovie/movies/MoviesWidget.dart';

import 'package:flutter_doubanmovie/citys/CitysWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StateManager/ShareDataInheritedWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '豆瓣电影',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '豆瓣电影'),
      routes: { // 添加路由
        '/Citys': (context) => CitysWidget()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  // 新建变量, 存储当前城市
  String curCity;

  List  _widetItems = [HotWidget(), MoviesWidget(), MineWidget()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShareDataInheritedWidget(
        curCity, // 默认值
        child: _widetItems[_selectedIndex], /// 选中不同的选项展示不同的页面
      ),
      bottomNavigationBar: BottomNavigationBar(
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('热映')),
            BottomNavigationBarItem(icon: Icon(Icons.panorama_fish_eye), title: Text('找片')),
            BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的'))
          ],
        currentIndex: 0, /// 默认选中第一个
        fixedColor: Colors.black,  /// 选中时, 颜色变为黑色
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    /// 刷新页面
    setState(() {
      _selectedIndex = index;
    });
  }

  void _initData() async{

    final prefs = await SharedPreferences.getInstance();

    String city = prefs.get('curCity'); // 获取 key 为 curCity 的值

    if (city != null && city.isNotEmpty) {
      setState((){
        curCity = city;
      });
    }else{
      setState((){
        curCity = '深圳';
      });
    }
  }

}
