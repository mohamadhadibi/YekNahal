import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/our_team_respoonse.dart';
import 'package:yek_nahal/utils/utils.dart';

class RowOurTeam extends StatefulWidget {
  List<OurTeam> team = [];
  Function _onTeamClicked;

  RowOurTeam(this.team, this._onTeamClicked);

  @override
  State<StatefulWidget> createState() {
    return _RowOurTeam();
  }
}

class _RowOurTeam extends State<RowOurTeam> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget child, MainModel model) {
        int itemCount = widget.team.length;
        return GridView.builder(
          itemBuilder: _onBindView,
          itemCount: itemCount,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        );
      },
    );
  }

  Widget _onBindView(BuildContext context, int index) {
    OurTeam member = widget.team[index];
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
                  image: NetworkImage(member.avatar),
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
                    member.name,
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
        widget._onTeamClicked(index);
      },
    );
  }
}
