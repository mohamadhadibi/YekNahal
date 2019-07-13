import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:yek_nahal/widgets/Toolbar.dart';

class YekNahalMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _YekNahalMapPage();
  }
}

class _YekNahalMapPage extends State<YekNahalMapPage> {
  Uri staticMapUri;

  @override
  void initState() {
    getStaticMap();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Scaffold(
          appBar: makeAppbar('نقشه یک نهال', context),
          body: Container(
            child: Image.network(staticMapUri.toString()),
          ),
        );
      },
    );
  }

  void getStaticMap() async {
    final provider = new StaticMapProvider(map_debug);
    final Uri tempStaticMapUri = provider.getStaticUriWithMarkersAndZoom(
        [Marker('position', 'یک نهال', 30.284791, 57.126263)],
        center: Location(30.284791, 57.126263),
        width: 400,
        height: 700,
        maptype: StaticMapViewType.roadmap,
        zoomLevel: 17);
    setState(() {
      staticMapUri = tempStaticMapUri;
    });
  }

  void showLiveMap() {
    Marker marker = Marker('position', 'یک نهال', 30.284791, 57.126263);
    final cameraPosition = CameraPosition(Location(30.284791, 57.126263), 14);
    final mapView = MapView();
    mapView.show(MapOptions(
      initialCameraPosition: cameraPosition,
      mapViewType: MapViewType.normal,
      title: 'یک نهال',
    ));

    mapView.onMapReady.listen((_){
      mapView.setMarkers([marker]);
    });
  }
}
