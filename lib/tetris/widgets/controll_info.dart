import 'package:flutter/material.dart';

import '../configs.dart';
import '../feature/size_calculation/get_field_panel_size.dart';
import '../model/enum/tetris_colors.dart';
import 'buttons.dart';

class ControllInfo extends StatelessWidget {
  const ControllInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getFieldPanelSize(context) * controllerWidthBlockNumber,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: TabBar(
                labelColor: TetrisColors.white.color,
                unselectedLabelColor: TetrisColors.grey.color,
                indicatorColor: TetrisColors.white.color,
                tabs: const [
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Button'),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('KeyBoard'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: const TabBarView(
                children: [Buttons(), Buttons()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
