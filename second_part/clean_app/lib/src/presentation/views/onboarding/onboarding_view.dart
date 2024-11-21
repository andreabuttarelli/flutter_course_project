import 'dart:convert';
import 'dart:typed_data';

import 'package:clean_app/src/presentation/design_system/guidelines/grid.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/src/presentation/design_system/components/atoms/primary_button.dart';
import 'package:clean_app/src/presentation/design_system/typography/body_typo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:password_strength/password_strength.dart';
import 'package:http/http.dart' as http;
/*
- Profile picture
- Data di nascita
- Slider personalità
- Dropdown nazionalità
- File PDF
*/

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final formKey = GlobalKey<FormState>();

  late Box box;
  static const boxName = 'form_data';

  Exception? error;
  Future<List<String>>? countries;

  @override
  void initState() {
    super.initState();
    openBox();
    countries = getCountries();
  }

  void checkError(void Function() callback) {
    try {
      callback();
    } on Exception catch (e) {
      setState(() {
        error = e;
      });
    }
  }

  void openBox() => checkError(() async {
        box = await Hive.openBox(boxName);
      });

  Future<List<String>> getCountries() async {
    const res =
        r'''{"status":"OK","status-code":200,"version":"1.0","access":"public","total":249,"offset":0,"limit":100,"data":{"DZ":{"country":"Algeria","region":"Africa"},"AO":{"country":"Angola","region":"Africa"},"BJ":{"country":"Benin","region":"Africa"},"BW":{"country":"Botswana","region":"Africa"},"BF":{"country":"Burkina Faso","region":"Africa"},"BI":{"country":"Burundi","region":"Africa"},"CV":{"country":"Cabo Verde","region":"Africa"},"CM":{"country":"Cameroon","region":"Africa"},"CF":{"country":"Central African Republic (the)","region":"Africa"},"TD":{"country":"Chad","region":"Africa"},"KM":{"country":"Comoros (the)","region":"Africa"},"CD":{"country":"Congo (the Democratic Republic of the)","region":"Africa"},"CG":{"country":"Congo (the)","region":"Africa"},"CI":{"country":"Côte d'Ivoire","region":"Africa"},"DJ":{"country":"Djibouti","region":"Africa"},"EG":{"country":"Egypt","region":"Africa"},"GQ":{"country":"Equatorial Guinea","region":"Africa"},"ER":{"country":"Eritrea","region":"Africa"},"SZ":{"country":"Eswatini","region":"Africa"},"ET":{"country":"Ethiopia","region":"Africa"},"GA":{"country":"Gabon","region":"Africa"},"GM":{"country":"Gambia (the)","region":"Africa"},"GH":{"country":"Ghana","region":"Africa"},"GN":{"country":"Guinea","region":"Africa"},"GW":{"country":"Guinea-Bissau","region":"Africa"},"KE":{"country":"Kenya","region":"Africa"},"LS":{"country":"Lesotho","region":"Africa"},"LR":{"country":"Liberia","region":"Africa"},"LY":{"country":"Libya","region":"Africa"},"MG":{"country":"Madagascar","region":"Africa"},"MW":{"country":"Malawi","region":"Africa"},"ML":{"country":"Mali","region":"Africa"},"MR":{"country":"Mauritania","region":"Africa"},"MU":{"country":"Mauritius","region":"Africa"},"YT":{"country":"Mayotte","region":"Africa"},"MA":{"country":"Morocco","region":"Africa"},"MZ":{"country":"Mozambique","region":"Africa"},"NA":{"country":"Namibia","region":"Africa"},"NE":{"country":"Niger (the)","region":"Africa"},"NG":{"country":"Nigeria","region":"Africa"},"RE":{"country":"Réunion","region":"Africa"},"RW":{"country":"Rwanda","region":"Africa"},"SH":{"country":"Saint Helena, Ascension and Tristan da Cunha","region":"Africa"},"ST":{"country":"Sao Tome and Principe","region":"Africa"},"SN":{"country":"Senegal","region":"Africa"},"SC":{"country":"Seychelles","region":"Africa"},"SL":{"country":"Sierra Leone","region":"Africa"},"SO":{"country":"Somalia","region":"Africa"},"ZA":{"country":"South Africa","region":"Africa"},"SS":{"country":"South Sudan","region":"Africa"},"SD":{"country":"Sudan (the)","region":"Africa"},"TZ":{"country":"Tanzania, the United Republic of","region":"Africa"},"TG":{"country":"Togo","region":"Africa"},"TN":{"country":"Tunisia","region":"Africa"},"UG":{"country":"Uganda","region":"Africa"},"EH":{"country":"Western Sahara*","region":"Africa"},"ZM":{"country":"Zambia","region":"Africa"},"ZW":{"country":"Zimbabwe","region":"Africa"},"AQ":{"country":"Antarctica","region":"Antarctic"},"BV":{"country":"Bouvet Island","region":"Antarctic"},"TF":{"country":"French Southern Territories (the)","region":"Antarctic"},"HM":{"country":"Heard Island and McDonald Islands","region":"Antarctic"},"GS":{"country":"South Georgia and the South Sandwich Islands","region":"Antarctic"},"AF":{"country":"Afghanistan","region":"Asia"},"AM":{"country":"Armenia","region":"Asia"},"AZ":{"country":"Azerbaijan","region":"Asia"},"BD":{"country":"Bangladesh","region":"Asia"},"BT":{"country":"Bhutan","region":"Asia"},"IO":{"country":"British Indian Ocean Territory (the)","region":"Asia"},"BN":{"country":"Brunei Darussalam","region":"Asia"},"KH":{"country":"Cambodia","region":"Asia"},"CN":{"country":"China","region":"Asia"},"GE":{"country":"Georgia","region":"Asia"},"HK":{"country":"Hong Kong","region":"Asia"},"IN":{"country":"India","region":"Asia"},"ID":{"country":"Indonesia","region":"Asia"},"JP":{"country":"Japan","region":"Asia"},"KZ":{"country":"Kazakhstan","region":"Asia"},"KP":{"country":"Korea (the Democratic People's Republic of)","region":"Asia"},"KR":{"country":"Korea (the Republic of)","region":"Asia"},"KG":{"country":"Kyrgyzstan","region":"Asia"},"LA":{"country":"Lao People's Democratic Republic (the)","region":"Asia"},"MO":{"country":"Macao","region":"Asia"},"MY":{"country":"Malaysia","region":"Asia"},"MV":{"country":"Maldives","region":"Asia"},"MN":{"country":"Mongolia","region":"Asia"},"MM":{"country":"Myanmar","region":"Asia"},"NP":{"country":"Nepal","region":"Asia"},"PK":{"country":"Pakistan","region":"Asia"},"PH":{"country":"Philippines (the)","region":"Asia"},"SG":{"country":"Singapore","region":"Asia"},"LK":{"country":"Sri Lanka","region":"Asia"},"TW":{"country":"Taiwan (Province of China)","region":"Asia"},"TJ":{"country":"Tajikistan","region":"Asia"},"TH":{"country":"Thailand","region":"Asia"},"TL":{"country":"Timor-Leste","region":"Asia"},"TM":{"country":"Turkmenistan","region":"Asia"},"UZ":{"country":"Uzbekistan","region":"Asia"},"VN":{"country":"Viet Nam","region":"Asia"},"BZ":{"country":"Belize","region":"Central America"}}}''';
    return (jsonDecode(res)['data'] as Map)
        .values
        .map((e) => (e as Map)['country'] as String)
        .toList();
  }

  void save() {
    //box.put('email', emailController.text);
  }

  void restore() {
    //emailController.text = box.get('email', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), actions: [
        TextButton(
          onPressed: save,
          child: const BodyTypo(label: 'Save'),
        ),
        TextButton(
          onPressed: restore,
          child: const BodyTypo(label: 'Restore'),
        ),
      ]),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            FormField<Uint8List?>(
              initialValue: null,
              builder: (state) => Column(
                children: [
                  Row(
                    children: [
                      if (state.value != null)
                        Image.memory(
                          state.value!,
                          width: 88,
                          height: 88,
                        )
                      else
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: const SizedBox(width: 88, height: 88),
                        ),
                      const Gap(16),
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: ImageSource.gallery,
                            child: BodyTypo(label: 'Photo Gallery'),
                          ),
                          DropdownMenuItem(
                            value: ImageSource.camera,
                            child: BodyTypo(label: 'Camera'),
                          ),
                        ],
                        onChanged: (value) async {
                          if (value == null) return;
                          final picker = ImagePicker();
                          final file = await picker.pickImage(source: value);
                          assert(file != null);
                          state.didChange(await file!.readAsBytes());
                        },
                        icon: const Row(
                          children: [
                            Icon(
                              CupertinoIcons.arrow_up_to_line,
                            ),
                            Gap(Grid.sm),
                            BodyTypo(label: 'Upload image'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.hasError)
                    BodyTypo(
                      label: state.errorText!,
                      color: Colors.red,
                    ),
                ],
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please upload an image';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _Field<DateTime>(
              validator: (value) {
                if (value == null) {
                  return 'Please select a birth date';
                }
                return null;
              },
              builder: (state) => InkWell(
                onTap: () async {
                  final res = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                  );
                  state.didChange(res);
                },
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.calendar),
                    const Gap(Grid.sm),
                    if (state.value == null)
                      const BodyTypo(label: 'Select a birth date')
                    else
                      BodyTypo(
                          label:
                              '${state.value!.day}/${state.value!.month}/${state.value!.year}'),
                  ],
                ),
              ),
            ),
            const Gap(Grid.md),
            _Field<String>(
                builder: (state) => FutureBuilder(
                      future: countries,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snap.hasError) {
                          return BodyTypo(label: snap.error.toString());
                        }
                        return DropdownButton<String>(
                          value: state.value,
                          items: snap.requireData
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: BodyTypo(label: e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            assert(value != null);
                            state.didChange(value!);
                          },
                        );
                      },
                    ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a country';
                  }
                  return null;
                }),
            const Gap(Grid.md),
            _Field<double>(
              initialValue: 0,
              builder: (state) => Slider(
                value: state.value!,
                onChanged: (value) => state.didChange(value),
              ),
              validator: (value) => null,
            ),
            PrimaryButton(
              label: 'Submit',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('OK');
                } else {
                  print('Invalid form');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordFieldState {
  PasswordFieldState({
    required this.textValue,
    required this.strength,
  });

  String textValue;
  double strength;

  factory PasswordFieldState.initial(String initialValue) => PasswordFieldState(
        textValue: initialValue,
        strength: estimatePasswordStrength(initialValue),
      );
}

class _Field<T> extends StatelessWidget {
  const _Field({
    super.key,
    this.initialValue,
    required this.builder,
    required this.validator,
  });

  final T? initialValue;
  final Widget Function(FormFieldState<T>) builder;
  final String? Function(T?) validator;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      validator: validator,
      builder: (state) => Column(
        children: [
          builder.call(state),
          if (state.hasError)
            BodyTypo(
              label: state.errorText!,
              color: Colors.red,
            ),
        ],
      ),
    );
  }
}
