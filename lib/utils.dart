import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle safeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans 3",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}
class Utils {


  static toast(String message, {bool success = true}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: success ? Colors.green : Colors.red,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}

class ChatRouteAdapter {

  List items = <Message>[];
  BuildContext context;
  Function onItemClick;
  ScrollController scrollController = new ScrollController();

  ChatRouteAdapter(this.context, this.items, this.onItemClick);

  void insertSingleItem(Message msg) {
    int insertIndex = items.length;
    items.insert(insertIndex, msg);
    scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut
    );
  }

  Widget getView() {
    return ListView.builder(itemCount: items.length,
      padding: EdgeInsets.symmetric(vertical: 10),
      controller: scrollController,
      itemBuilder: (context, index) {
        Message item = items[index];
        return buildListItemView(index, item);
      },
    );
  }

  Widget buildListItemView(int index, Message item){
    bool isMe = item.fromMe;
    return Row(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        isMe ? Spacer(flex: 2) : Container(width: 10, height: 0),
        isMe ? Container(width: 0, height: 0) : Container(
          width: 30, height: 30, margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: CircleImage(
            imageProvider: AssetImage('assets/screens/images/Artist.jpg'),
            size: 30.0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Container(width: isMe ? 0 : 5),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.date, style: TextStyle(fontSize: 10, color: Colors.grey)),
              Container(
                child: Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),),
                    margin: EdgeInsets.fromLTRB(isMe ? 20 : 0, 0, isMe ? 0 : 20, 5),
                    color: isMe ? Color(0xff5EA1D5) : Colors.grey, elevation: 0,
                    child : Padding(
                      padding: EdgeInsets.fromLTRB(4, 5, 4, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          isMe ? Container(width:12, height:12, alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(5, 3, 5, 5),
                            decoration: BoxDecoration(color: Color(0xff769738), borderRadius: BorderRadius.circular(12.0)),
                            child: Text("R", style: TextStyle(fontSize: 10, color: Colors.white, fontStyle: FontStyle.italic)),
                          ) : Container(width : 7, height : 7, margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12.0)),
                          ),
                          Expanded(
                            child: Text(item.content, style: subhead(context).copyWith(
                                color: isMe ? Colors.white : Colors.grey)
                            ),
                          )
                        ],
                      ),
                    )
                ),
              )
            ],
          ),
        ),
        isMe ? Container(width: 10, height: 0) : Spacer(flex: 2),
      ],
    );
  }

  int getItemCount() => items.length;

}
class CircleImage extends StatelessWidget {

  final double size;
  final Color backgroundColor;
  final ImageProvider imageProvider;

  const CircleImage({
    Key? key,
    required this.imageProvider,
    required this.size,
    required this.backgroundColor,

    

  }) : assert(imageProvider != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    return Container(
        width: size != null ? size : 20,
        height: size != null ? size : 20,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor != null ? backgroundColor : Colors.transparent,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: imageProvider
            )
        )
    );
  }
}
  TextStyle subhead(BuildContext context){
      return Theme.of(context).textTheme.titleMedium!;
    }
class Message{
  int id;
  String date;
  String content;
  bool fromMe;
  bool showTime = true;

  Message(int id, String content, bool fromMe, String date)
      : id = id,
        content = content,
        fromMe = fromMe,
        date = date {
    // constructor body
  }
 

  Message.time(int id, String content, bool fromMe, bool showTime, String date)
      : id = id,
        content = content,
        fromMe = fromMe,
        showTime = showTime,
        date = date {
    // constructor body
  }


}