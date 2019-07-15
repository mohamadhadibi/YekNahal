import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';
import 'package:yek_nahal/utils/utils.dart';

class RowBlog extends StatelessWidget {
  BlogOb model;
  List<BlogOb> blogs;
  Function _onBlogClicked;

  RowBlog(this.blogs, this._onBlogClicked);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainModel model) {
        int itemCount = blogs.length;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: _onBindView,
          itemCount: itemCount,
        );
      },
    );
  }

  Widget _onBindView(BuildContext context, int index) {
    BlogOb blog = blogs[index];
    return GestureDetector(
      child: Container(
        width: 200,
        margin: EdgeInsets.all(10.0),
        child: Card(
          elevation: 20,
          child: ClipPath(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(blog.image),
                  placeholder: AssetImage(image_place_holder),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/ic_row_mask.png',
                  width: 200,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  margin: EdgeInsetsDirectional.only(bottom: 10, start: 10),
                  child: Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _onBlogClicked(index);
      },
    );
  }
}
