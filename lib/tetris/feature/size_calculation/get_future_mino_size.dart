import 'package:flutter/material.dart';

import '../../configs.dart';
import 'get_field_panel_size.dart';

double getFutureMinoSize(BuildContext context) =>
    getFieldPanelSize(context) * futureMinoSizeRatio;
