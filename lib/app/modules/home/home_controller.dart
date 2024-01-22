import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_games_case/generated/locales.g.dart';

import '../../../../core/utils/getx_extensions.dart';
import '../../../core/utils/utils.dart';
import '../../../core/variables/colors.dart';
import '../../models/hobby_models/hobby_model.dart';
import '../../repositories/hobby_repository.dart';
import '../common/widgets/buttons/custom_elevated_button.dart';
import '../common/widgets/textfield/custom_text_form_field.dart';
import '../common/widgets/texts/custom_text.dart';

enum HomeState { Initial, Busy, Loaded, Error }

class HomeController extends GetxController {
  final HobbyRepository _hobbyRepository = Get.find<HobbyRepository>();
  final Rx<HomeState> _state = HomeState.Initial.obs;
  HomeState get state => _state.value;
  set state(HomeState value) => _state.value = value;

  final RxList<HobbyModel> _hobbies = <HobbyModel>[].obs;
  List<HobbyModel> get hobbies => _hobbies.value;
  set hobbies(List<HobbyModel> value) => _hobbies.value = value;

  @override
  void onInit() {
    ever(_state, (HomeState value) {
      switch (value) {
        case HomeState.Busy:
          Get.showProgressDialog();
          break;
        case HomeState.Loaded:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        case HomeState.Error:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        default:
      }
    });
    super.onInit();
  }

  @override
  onReady() async {
    await getAllHobby();
    super.onReady();
  }

  Future<void> getAllHobby() async {
    errorHandler(
      tryMethod: () async {
        state = HomeState.Busy;
        hobbies = await _hobbyRepository.getAllHobby();
        state = HomeState.Loaded;
      },
      onErr: () async {
        state = HomeState.Error;
      },
    );
  }

  Future<void> deleteHobbyOnTap(HobbyModel hobby) async {
    if (hobby.id == null) return;
    Get.showAwesomeDialog(
      title: LocaleKeys.common_warning.tr,
      subtitle: LocaleKeys.hobby_delete_subtitle.tr,
      dialogType: DialogType.WARNING,
      btnOkOnPressed: () async {
        Get.back();
        errorHandler(
          tryMethod: () async {
            state = HomeState.Busy;
            final result = await _hobbyRepository.removeHobby(hobby.id ?? "");
            hobbies.removeWhere((element) => element.id == hobby.id);
            state = HomeState.Loaded;
            _hobbies.refresh();
            Get.showToast(LocaleKeys.common_hobby_delete_succes.tr, toastStyle: ToastStyle.SUCCESS);
          },
          onErr: () async => state = HomeState.Error,
        );
      },
      btnCancelOnPressed: () => Get.back(),
    );
  }

  Future<void> fabButtonOnTap() async {
    HobbyModel newHobby = HobbyModel(id: (hobbies.length + 1).toString(), name: null);
    Get.showAwesomeDialog(
      disableBtnCancel: true,
      disableBtnOk: true,
      customHeader: Padding(
        padding: EdgeInsets.all(Utils.lowPadding),
        child: CircleAvatar(
          maxRadius: Get.width,
          backgroundColor: Get.theme.primaryColor,
          child: Icon(
            Icons.add_circle_outline,
            color: ColorTable.getReversedTextColor,
            size: Utils.extraHighIconSize * 2.25,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Utils.normalPadding),
        child: Column(
          children: [
            CustomTextFormField(hintText: LocaleKeys.common_hobby_name.tr, onChangeComplete: (val) => newHobby.name = val),
            SizedBox(height: Utils.normalPadding),
            CustomElevatedButton(
              minimumWith: Get.width,
              child: CustomText(LocaleKeys.common_add_hobby.tr, textColor: ColorTable.getReversedTextColor, bold: true),
              onPressed: () async {
                Get.back();
                if ((newHobby.name ?? "").isEmpty) return;
                final result = await _hobbyRepository.addHobby(newHobby);
                hobbies.add(newHobby);
                _hobbies.refresh();
                Get.showToast(LocaleKeys.common_hobby_add_succes.tr, toastStyle: ToastStyle.SUCCESS);
              },
            )
          ],
        ),
      ),
    );
  }
}
