import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';

import 'color_numbers.dart';

class ColorList extends StatefulWidget {
  final int indexNo;

  const ColorList(
      this.indexNo, {super.key});

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {

  int? activeColor = 0;
  ColorNumbers colorNumbers = ColorNumbers();

  void setColor(int index){

    setState(() {
      activeColor = index;
    });
    Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(index);


  }

  @override

  Widget build(BuildContext context) {
    return ((widget.indexNo) > 72 && (widget.indexNo) < 77)
        ? ListTile(tileColor: HexColor('#ffeade'))
        : ((widget.indexNo) == 77)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak1.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(84)),onTap: () {setColor(84);}),)
        : ((widget.indexNo) == 78)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak2.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(85)),onTap: () {setColor(85);}),)
        : ((widget.indexNo) == 79)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak3.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(86)),onTap: () {setColor(86);}),)
        : ((widget.indexNo) == 80)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak4.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(87)),onTap: () {setColor(87);}),)
        : ((widget.indexNo) == 81)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak5.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(88)),onTap: () {setColor(88);}),)
        : ((widget.indexNo) == 82)
        ? ListTile(tileColor: HexColor('#ffeade'))
        : ((widget.indexNo) == 83)
        ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/crackedBrick.png'),fit: BoxFit.fill)), child: ListTile(tileColor: HexColor(colorNumbers.getColor(90)),onTap: () {setColor(90);}),)
        : ListTile(tileColor: HexColor(colorNumbers.getColor(widget.indexNo)), onTap: () {setColor(widget.indexNo);});
  }


// Widget build(BuildContext context) {
//    return ((widget.indexNo) > 77) ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/nonBreak1.png'),fit: BoxFit.fill)),
//      child: ListTile(
//       tileColor: (widget.indexNo) < 77 ? HexColor(colorNumbers.getColor(widget.indexNo)) : HexColor(colorNumbers.getColor((widget.indexNo) + 7)),
//       onTap: () {
//
//         if ((widget.indexNo) < 77){setColor(widget.indexNo);print('${widget.indexNo}');} else {setColor((widget.indexNo) + 7);print('${widget.indexNo+7}');}}
//
//         //(widget.indexNo) < 77 ? setColor(widget.indexNo) : setColor((widget.indexNo) + 7);},
//
//          ),
//    ) :
//
//    Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/onBreak1.png'),fit: BoxFit.fill)),
//      child: ListTile(
//          tileColor: HexColor(colorNumbers.getColor(widget.indexNo)),
//          onTap: () {
//
//            setColor(widget.indexNo);}
//
//          //if ((widget.indexNo) < 77){setColor(widget.indexNo);print('${widget.indexNo}');} else {setColor((widget.indexNo) + 7);print('${widget.indexNo+7}');}}
//        //(widget.indexNo) < 77 ? setColor(widget.indexNo) : setColor((widget.indexNo) + 7);},
//
//      ),
//    )
//
//    ;
// }
}