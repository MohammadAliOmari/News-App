// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// def button
Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        double reduis = 0.0,
        required Function() function,
        required String text}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(reduis),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

// text form filed
Widget defaultTextformfiled({
  required String labeltext,
  var control,
  required var preicon,
  required var textinput,
  required Function validate,
  var suficon,
  void Function(String)? onChange,
  bool obscureText1 = false,
  Function? obsfunction,
}) =>
    TextFormField(
        onChanged: onChange,
        controller: control,
        keyboardType: textinput,
        decoration: InputDecoration(
          labelText: labeltext,
          prefixIcon: Icon(preicon),
          suffixIcon: IconButton(
            icon: Icon(suficon),
            onPressed: () {
              obsfunction!;
            },
          ),
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText1,
        validator: (b) {
          return validate(b);
        });

Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              '${model['time']}',
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );

Widget buildArticaleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                    '${article['urlToImage'] ?? "https://api.uznews.uz/images/default-image.jpg"}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

class Mainbtn extends StatefulWidget {
  final String text;
  final Function() pris;
  final Color? dcolors, textcolor;

  const Mainbtn({
    Key? key,
    required this.text,
    required this.pris,
    this.textcolor = Colors.amber,
    this.dcolors,
  }) : super(key: key);

  @override
  State<Mainbtn> createState() => _MainbtnState();
}

class _MainbtnState extends State<Mainbtn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            backgroundColor: Colors.blue,
          ),
          onPressed: widget.pris,
          child: Text(
            widget.text,
            style: TextStyle(color: widget.textcolor),
          )),
    );
  }
}

Widget articleBuilder(list, {isSearch = false}) {
  if (list.length > 0) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticaleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length);
  } else {
    return Center(
      child: isSearch ? Container() : CircularProgressIndicator(),
    );
  }
}
