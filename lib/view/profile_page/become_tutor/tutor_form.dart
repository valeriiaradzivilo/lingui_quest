import 'package:currency_picker/currency_picker.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_number_editing_field.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';

class TutorForm extends StatefulWidget {
  const TutorForm({super.key, required this.user});

  final UserModel user;

  @override
  State<TutorForm> createState() => _TutorFormState();
}

class _TutorFormState extends State<TutorForm> {
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _preferencesController = TextEditingController();
  Currency? _currency;
  final Map<TextEditingController, TextEditingController> _contacts = {
    TextEditingController(): TextEditingController()
  };
  final Map<TextEditingController, TextEditingController> _price = {TextEditingController(): TextEditingController()};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.tutorFormTitle),
      actions: [
        LinButton(
          label: context.loc.cancel,
          onTap: () => Navigator.maybePop(context),
          isTransparentBack: true,
          icon: FeatherIcons.x,
        ),
        LinButton(
          label: context.loc.save,
          onTap: () {},
          icon: FeatherIcons.check,
        ),
      ],
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingConst.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _MainText(context.loc.aboutTutorInfo),
              Gap(PaddingConst.large),
              LinTextField(
                controller: _aboutController,
                label: context.loc.aboutTutor,
              ),
              Gap(PaddingConst.large),
              _MainText(context.loc.contactsTutor),
              Gap(PaddingConst.large),
              _TwoTextFormFieldsFromMap(
                map: _contacts,
                keyHint: context.loc.contactsType,
                valueHint: context.loc.contactsLink,
              ),
              Gap(PaddingConst.large),
              _MainText(context.loc.currencyTutor),
              Gap(PaddingConst.large),
              ElevatedButton(
                  onPressed: () => showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) {
                          setState(() => _currency = currency);
                        },
                      ),
                  child: _MainText(_currency == null ? context.loc.tapToChangeCurrency : _currency!.name)),
              Gap(PaddingConst.large),
              _MainText(context.loc.priceTutor),
              Gap(PaddingConst.large),
              _TwoTextFormFieldsFromMap(
                map: _price,
                keyHint: context.loc.lessonType,
                valueHint: context.loc.price,
                isValueNumberType: true,
              ),
              Gap(PaddingConst.large),
              _MainText(context.loc.preferencesTutorInfo),
              Gap(PaddingConst.large),
              LinTextField(
                controller: _preferencesController,
                label: context.loc.preferencesTutor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainText extends StatelessWidget {
  const _MainText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleMedium,
    );
  }
}

class _TwoTextFormFieldsFromMap extends StatefulWidget {
  const _TwoTextFormFieldsFromMap(
      {required this.map, required this.keyHint, required this.valueHint, this.isValueNumberType = false});
  final Map<TextEditingController, TextEditingController> map;
  final String keyHint;
  final String valueHint;
  final bool isValueNumberType;

  @override
  State<_TwoTextFormFieldsFromMap> createState() => _TwoTextFormFieldsFromMapState();
}

class _TwoTextFormFieldsFromMapState extends State<_TwoTextFormFieldsFromMap> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < widget.map.length; i++) ...[
          Container(
            padding: EdgeInsets.all(PaddingConst.large),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  child: LinTextField(
                    controller: widget.map.keys.elementAt(i),
                    label: widget.keyHint,
                  ),
                ),
                const MaxGap(50),
                Flexible(
                  flex: 3,
                  child: widget.isValueNumberType
                      ? LinNumberEditingField(
                          controller: widget.map.values.elementAt(i),
                          label: widget.valueHint,
                        )
                      : LinTextField(
                          controller: widget.map.values.elementAt(i),
                          label: widget.valueHint,
                        ),
                ),
                const Spacer(),
                IconButton.outlined(
                    color: theme.colorScheme.error,
                    onPressed: () => setState(() => widget.map.removeWhere((key, value) =>
                        key.text == widget.map.keys.elementAt(i).text &&
                        value.text == widget.map.values.elementAt(i).text)),
                    icon: const Icon(FeatherIcons.trash2))
              ],
            ),
          ),
          Gap(PaddingConst.medium),
        ],
        Gap(PaddingConst.large),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton.filled(
              onPressed: () {
                setState(() => widget.map.addAll({TextEditingController(): TextEditingController()}));
              },
              icon: const Icon(FeatherIcons.plusCircle)),
        ),
      ],
    );
  }
}
