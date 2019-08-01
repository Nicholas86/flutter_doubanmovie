
import 'package:flutter/widgets.dart';

class ShareDataInheritedWidget extends InheritedWidget{
  String curCity ;

  // curCity 就是要存储的全局数据，而且要通过构造函数传入。
  ShareDataInheritedWidget(this.curCity,{Widget child}):super(child:child);

  /*
  updateShouldNotify() 方法是，当全局数据发生变化，InheritedWidget 发生重建，
  判断需不需要通知依赖 InheritedWidget 数据的子 Widget，返回 true 是通知，返回 false 是不通知，这里写的是：
  意思是当旧的数据和新的数据不一致时，就返回 true，否则返回 false。
   */
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return (oldWidget as ShareDataInheritedWidget).curCity != curCity;
  }

  //定义一个便捷方法，方便子树中的 Widget 获取 ShareDataInheritedWidget 实例
  static ShareDataInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataInheritedWidget);
  }

}
