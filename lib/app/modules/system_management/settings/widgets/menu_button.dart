import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/getx_extensions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';
import '../../../../routes/page_result_model.dart';
import '../../../common/widgets/icons/icon_with_background.dart';
import '../../../common/widgets/texts/custom_text.dart';

class MenuButton extends StatefulWidget {
  ///Butonun text alanı
  final String menuName;

  ///icon path verilirse bu değer ezilir
  final IconData? icon;

  ///icon path verilirse icon ezilir
  final String? iconPath;

  //Text'den önce icon gösterir. Ör: language settings icin bayrak iconu
  final String? secondIconPath;

  final String? flagPath;

  ///Eğer on tap null ise menu tıklandığında bu sayfaya yönlendirilir.
  final String? pageReferance;

  ///Menu sonundaki ileri iconunun gösterilip gösterilmeyeceğini belirler
  final bool showTrailingIcon;

  final Function()? onTap;

  final dynamic arguments;

  final Widget? menuView;

  const MenuButton({
    Key? key,
    this.flagPath,
    required this.menuName,
    this.icon,
    this.iconPath,
    this.showTrailingIcon = true,
    this.onTap,
    this.pageReferance,
    this.arguments,
    this.secondIconPath,
    this.menuView,
  }) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap ??
          () async {
            if (widget.pageReferance == null) return;
            final result = await Get.toNamed(widget.pageReferance!, arguments: widget.arguments);
            if (result is PageResult && result.toastMsg != null && result.toastMsg!.isNotEmpty) {
              Get.showToast(
                result.toastMsg!,
                toastStyle: result.toastStyle,
              );
            }
          },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(left: Utils.normalPadding, top: Utils.normalPadding, bottom: Utils.normalPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.iconPath != null
                        ? IconWithBackground.withAsset(iconPath: widget.iconPath, iconColor: Get.theme.primaryColor)
                        : widget.icon != null
                            ? IconWithBackground.withIcon(icon: widget.icon)
                            : const SizedBox(),
                    if (widget.secondIconPath != null)
                      Padding(
                        padding: EdgeInsets.only(left: Utils.lowPadding),
                        child: Image.asset(
                          widget.secondIconPath!,
                          height: Utils.extraHighIconSize,
                          width: Utils.extraHighIconSize,
                        ),
                      ),
                    if (widget.flagPath != null) Image.asset(widget.flagPath!, height: Utils.extraHighIconSize, width: Utils.extraHighIconSize),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Utils.lowPadding),
                        child: CustomText.extraHigh(widget.menuName, textColor: ColorTable.getTextColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.showTrailingIcon)
              Expanded(
                flex: 1,
                child: Icon(Icons.arrow_forward_ios_rounded, size: Utils.normalIconSize),
              ),
          ],
        ),
      ),
    );
  }
}
