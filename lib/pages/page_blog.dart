import 'package:flutter/material.dart';
import 'package:yek_nahal/models/blogs_response.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:yek_nahal/widgets/Toolbar.dart';

class BlogPage extends StatefulWidget {
  BlogOb blog;

  BlogPage(this.blog);

  @override
  State<StatefulWidget> createState() {
    return _BlogPage();
  }
}

class _BlogPage extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppbar(widget.blog.title,context),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(widget.blog.image),
            placeholder: AssetImage(image_place_holder),
          ),
          Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.all(20),
            child: Text(
              widget.blog.body,
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
