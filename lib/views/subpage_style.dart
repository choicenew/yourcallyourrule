  import 'package:flutter/material.dart';

const TextStyle entryTitleStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const TextStyle entryNameStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const TextStyle entryLabelStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const TextStyle entryLocationStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const TextStyle entryTimeStyle = TextStyle(
  fontSize: 12.0,
  //fontWeight: FontWeight.bold,
  color: Colors.black,
);
  // 订阅名称、订阅链接和打开本地文件夹输入框的样式
const TextStyle inputTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.black,
);

  // 输入框外边框的样式
const InputDecoration inputDecoration = InputDecoration(
  border: OutlineInputBorder( // 使用带有圆角的边框
    borderSide: BorderSide( // 设置边框颜色和宽度
      color: Color.fromARGB(255, 11, 220, 92),
      width: 10.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)), // 设置边框圆角
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // 设置内边距
);

final BoxDecoration inputBoxDecoration = BoxDecoration(
    //color: const Color.fromARGB(255, 255, 255, 255),
 border: Border.all(
  color: const Color.fromARGB(255, 4, 213, 67),
//  width: 1.0,
 ),
  borderRadius: const BorderRadius.all(Radius.circular(36.0)
  ),
);
  
  


  final BoxDecoration whiteBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
  border: Border.all(
    color: Colors.green,
    width: 2.0,
  ),
);

//搜索页的location信息
const TextStyle callerlocationTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

  // 黑名单和白名单文字的样式
const TextStyle whiteTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);
  // 黑名单和白名单开关的样式
const TextStyle shieldSwitchTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);
  

  
  // 添加按钮的样式
final ButtonStyle addButtonStyle = ButtonStyle(
 // backgroundColor: WidgetStateProperty.all(Colors.blue),
  // foregroundColor: MaterialStateProperty.all(Colors.white),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),  
  // 去掉图标
  // icon: MaterialStateProperty.all(Icon(Icons.add)),
  // 添加图标大小
  // iconSize: MaterialStateProperty.all(32.0),
  // 添加图标颜色
   iconColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
  // 添加文本大小
  textStyle: WidgetStateProperty.all(const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 18.0)),
 // minimumSize: MaterialStateProperty.all(Size(150.0, 40.0)), // 按钮的最小尺寸
);


 // 添加tab bar view的样式
class SubscriptionPageStyles {
  static const TextStyle tabLabelStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const Color tabBarBackgroundColor = Color.fromARGB(255, 248, 82, 82);
  static const Color selectedTabLabelColor = Colors.blue;
  static const Color unselectedTabLabelColor = Colors.black;

  static const EdgeInsets tabBarPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets tabViewPadding = EdgeInsets.all(16.0);

  static const TextStyle checkboxListTileTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  static const Color checkboxListTileActiveColor = Colors.blue; // Color for selected checkbox
  static const Color checkboxListTileInactiveColor = Colors.grey; // Color for unselected checkbox
  static const DividerThemeData dividerTheme = DividerThemeData(
  
    color: Color.fromARGB(255, 238, 215, 215),
    thickness: 1.0,
    indent: 16.0,
    endIndent: 16.0,
  );
}


const TextStyle subscriptionTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const EdgeInsets subscriptionTitlePadding = EdgeInsets.only(left: 16.0, right: 8.0);

const double statusIconSize = 18.0;
const Color offlineStatusIconColor = Colors.grey;

const Color onlineStatusIconColor = Colors.blue;
const Color whiteStatusIconColor = Colors.green;
const Color blackStatusIconColor = Colors.black;


  //定义方式
  const TextStyle showmoreTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
  // 输入框外边框的样式
const InputDecoration showmoreinputBoxDecoration = InputDecoration(
  border: OutlineInputBorder( // 使用带有圆角的边框
    borderSide: BorderSide( // 设置边框颜色和宽度
      //color: Colors.grey,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4.0)), // 设置边框圆角
  ),
 // contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // 设置内边距
);


final BoxDecoration showmoreBoxDecoration = BoxDecoration(
 border: Border.all(
  color: Colors.grey,
  width: 1.0,
 ),
  borderRadius: const BorderRadius.all(Radius.circular(4.0)
  ),
);

  // 添加按钮的样式
final ButtonStyle showmoreButtonStyle = ButtonStyle(
 // backgroundColor: WidgetStateProperty.all(Colors.blue),
  // foregroundColor: MaterialStateProperty.all(Colors.white),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),  
  // 去掉图标
  // icon: MaterialStateProperty.all(Icon(Icons.add)),
  // 添加图标大小
  // iconSize: MaterialStateProperty.all(32.0),
  // 添加图标颜色
   iconColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
  // 添加文本大小
  textStyle: WidgetStateProperty.all(const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 18.0)),
 // minimumSize: MaterialStateProperty.all(Size(150.0, 40.0)), // 按钮的最小尺寸
);


final ButtonStyle floatingButtonStyle = ButtonStyle(
 // backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(147, 203, 128, 1)),
 // foregroundColor: WidgetStateProperty.all(Colors.white),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),  
  // 去掉图标
  // icon: MaterialStateProperty.all(Icon(Icons.add)),
  // 添加图标大小
  // iconSize: MaterialStateProperty.all(32.0),
  // 添加图标颜色
   iconColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
  // 添加文本大小
  textStyle: WidgetStateProperty.all(const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 18.0)),
 // minimumSize: MaterialStateProperty.all(Size(150.0, 40.0)), // 按钮的最小尺寸
);

final BoxDecoration showmoreButtonBoxDecoration = BoxDecoration(
 border: Border.all(
  color: Colors.grey,
  width: 1.0,
 ),

 ); 



// 定义独立的 style
final ButtonStyle deleteButtonStyle = ButtonStyle(
  foregroundColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return Colors.red[900];
    }
    return Colors.red;
  }),
  backgroundColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return Colors.white;
    }
    return Colors.transparent;
  }),
);
