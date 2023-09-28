
import 'package:flutter/cupertino.dart';

import 'color_list.dart';

class ColorsGrid extends StatelessWidget {
  const ColorsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox (height: MediaQuery.of(context).size.height * 0.20,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 73,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 1.5),
            itemBuilder: (context, index) => ColorList(index),
          ),
        ),
      ],
    );
  }
}