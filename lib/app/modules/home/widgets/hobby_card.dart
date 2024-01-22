import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/variables/colors.dart';
import '../../../models/hobby_models/hobby_model.dart';
import '../../common/widgets/card/custom_card.dart';
import '../../common/widgets/texts/custom_text.dart';

class HobbyCard extends StatelessWidget {
  final HobbyModel hobbyModel;
  final Function(HobbyModel) deleteOnTap;
  const HobbyCard({super.key, required this.hobbyModel, required this.deleteOnTap});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => deleteOnTap(hobbyModel),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(hobbyModel.name),
          InkWell(
            onTap: () => deleteOnTap(hobbyModel),
            child: Icon(FeatherIcons.trash, color: ColorTable.errorColor, size: Utils.normalIconSize),
          ),
        ],
      ),
    );
  }
}
