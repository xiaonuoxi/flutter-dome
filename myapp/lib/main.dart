import 'package:flutter/material.dart';
import 'page/MyInfoPage.dart';
import 'page/DiscoveryPage.dart';
import 'page/NewsListPage.dart';
import 'page/TweetsListPage.dart';
// 内置ios风格tab
import 'package:flutter/cupertino.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: const Color(0xFF63CA6C),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  // 页面当前选择的tab的索引
   int _tableIndex = 0;


  // 页面body部分组件
//  Widget _body = new IndexedStack(
//    children: <Widget>[
//      new NewListPage(),
//      new TweetsListPage(),
//      new DiscoveryPage(),
//      new MyInfoPage()
//    ],
//    index: _tableIndex,
//  );

   Widget _bodyWidget(){
     return IndexedStack(
      children: <Widget>[
        new NewListPage(),
        new TweetsListPage(),
        new DiscoveryPage(),
        new MyInfoPage()
      ],
      index: _tableIndex,
    );
  }
  // currentIndex表示当前选中的Tab的索引值
  // onTap是TabItem点击事件
  List<BottomNavigationBarItem> getBottomNavItems(){
    List<BottomNavigationBarItem> list = new List();

    for(int i = 0; i<4;i++){
      list.add(new BottomNavigationBarItem(
          // ionc 图标
          icon: getTabIcon(i),
          // 标题
          title: getTabTitle(i)
      ));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
     // 初始化数据
    initData();

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: _bodyWidget(),
      // bottonNavigationBar 属性为页面底部添加导航的Tab，CupertionTabBar是flutter提供一个ios风格的底部导航栏组件
      bottomNavigationBar: new CupertinoTabBar(
          // 数据集合
          items: getBottomNavItems(),
          // 当前索引值
          currentIndex: _tableIndex,
          onTap: (index){
            // 底部TabItem的点击事件处理，点击时改变当前选择的Tab的索引值，则页面会自动刷新
            setState(() {
              _tableIndex = index;
            });
          },
      ),
      
    );
  }

  // 页面底部TabItem上的图标数组
  var tabIcons;

  //页面顶部的大标题（也是TabItem上的文本）
  var appBarTitles = ['资讯','动弹','发现','我的'];

  //数据初始化，包括TabIcon数据和页面内容数据
  void initData(){
    if(tabIcons == null){
      tabIcons = [
        [
         Icon(Icons.library_books,color: Color(0xFF63CA6C),),
         Icon(Icons.library_books,color: Colors.black38,)
        ],
        [
          Icon(Icons.data_usage,color: Color(0xFF63CA6C),),
          Icon(Icons.data_usage,color: Colors.black38,)
        ],
        [
          Icon(Icons.brightness_5,color: Color(0xFF63CA6C),),
          Icon(Icons.brightness_5,color: Colors.black38,)
        ],
        [
          Icon(Icons.sentiment_neutral,color: Color(0xFF63CA6C),),
          Icon(Icons.sentiment_neutral,color: Colors.black38,)
        ],
      ];
    }
  }


  // 根据索引值确定Tab是选中状态的样式还是非选中状态的样式
  TextStyle getTabTextStyle(int curIndex){
    if(curIndex == _tableIndex){
      return new TextStyle(
        color: Color(0xFF63CA6C),
        fontSize: 14
      );
    }
    return new TextStyle(
      color: Colors.black38
    );
  }

  // 根据索引值确定TableItem的icon是选中还是非选中
  getTabIcon(int curIndex) {
    if(curIndex == _tableIndex){
      return tabIcons[curIndex][0];
    }
    return tabIcons[curIndex][1];
  }

  //根据索引值返回页面顶部标题
  Text getTabTitle(int curIndex) {
    return new Text(
      appBarTitles[curIndex],
      style: getTabTextStyle(curIndex,),
    );
  }
}
