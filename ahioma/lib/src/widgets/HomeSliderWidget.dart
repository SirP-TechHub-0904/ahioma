import 'package:carousel_slider/carousel_slider.dart';
import 'package:ahioma/config/app_config.dart' as config;
import 'package:ahioma/src/models/slider.dart';
import 'package:ahioma/src/models/slider.dart' as prefix0;
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  SliderList list;
  HomeSliderWidget({this.list});
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  SliderList _sliderList = new SliderList();
  bool loading;
  Future getSlide() async {
    await _sliderList.getSliderList();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSlide();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.lisst.isEmpty) {
      return LinearProgressIndicator();
    } else
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
//      fit: StackFit.expand,
        children: <Widget>[
          CarouselSlider(
            options:  CarouselOptions(
                  height: 240,
                  // aspectRatio: /9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  // reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index,slide) {
                    setState(() {
                      _current = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
            items: widget.list.lisst.map((prefix0.Slider slide) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: 500,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('${slide.image}'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 9)
                      ],
                    ),
//                   child: Container(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Container(
//                       width: config.App(context).appWidth(40),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text(
//                             slide.description,
//                             style: Theme.of(context).textTheme.title.merge(TextStyle(height: 0.8)),
//                             textAlign: TextAlign.right,
//                             overflow: TextOverflow.fade,
//                             maxLines: 3,
//                           ),
//                           FlatButton(
//                             onPressed: () {
// //                              Navigator.of(context).pushNamed('/Checkout');
//                             },
//                             padding: EdgeInsets.symmetric(vertical: 5),
//                             color: Theme.of(context).accentColor,
//                             shape: StadiumBorder(),
//                             child: Text(
//                               slide.button,
//                               textAlign: TextAlign.start,
//                               style: TextStyle(color: Theme.of(context).primaryColor),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 25,
            right: 25,

//          width: config.App(context).appWidth(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.list.lisst.map((prefix0.Slider slide) {
                return Container(
                  width: 10.0,
                  height: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: _current == widget.list.lisst.indexOf(slide)
                          ? Theme.of(context).hintColor
                          : Theme.of(context).hintColor.withOpacity(0.3)),
                );
              }).toList(),
            ),
          ),
        ],
      );
  }
}
