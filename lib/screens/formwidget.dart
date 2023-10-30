import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/partners.dart';
import 'package:multiselect/multiselect.dart';
import 'dart:math' as math;

class FormWidget extends StatefulWidget {
  final String name;
  final String hivStatus;
  final String ethnicity;
  final String gender;
  final String injector;
  final String sexwithmen;
  final double hivProb;

  FormWidget(
      {Key? key,
      this.name = 'Partner Name',
      this.hivStatus = 'Unknown',
      this.ethnicity = 'Unknown',
      this.gender = 'Unknown',
      this.injector = 'Unknown',
      this.sexwithmen = 'Unknown',
      this.hivProb = -1})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final nameController = TextEditingController();
  final customProbController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  String hivstatusSelected = 'Unknown';
  String ethnicitySelected = 'Unknown';
  String genderSelected = 'Unknown';
  String injectorSelected = 'Unknown';
  String sexwithmenSelected = 'Unknown';
  List<String> exposureRoutesSelected = [];
  List<String> protectionSelected = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ethnicitySelected = widget.ethnicity;
        hivstatusSelected = widget.hivStatus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PartnerModel>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      title: const Text('Partner Information'),
      content: SizedBox(
        width: 1000,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NameField(nameController: nameController, widget: widget),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('HIV Status: '),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: hivstatusSelected,
                      hint: Text(hivstatusSelected),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          hivstatusSelected = value!;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          hivstatusSelected = value!;
                        });
                      },
                      items: const [
                        //add items in the dropdown
                        DropdownMenuItem(
                          value: "Unknown",
                          child: Row(
                            children: [
                              Icon(Icons.question_mark),
                              Text("Unknown/Prefer not to say"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Negative",
                          child: Row(
                            children: [
                              Icon(Icons.remove, color: Colors.green),
                              Text("Negative"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Positive",
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.red),
                              Text("Positive"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Custom",
                          child: Row(
                            children: [
                              Icon(Icons.percent, color: Colors.orange),
                              Text("Custom Estimate"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              if (hivstatusSelected == 'Custom') ...[
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Custom Estimate of HIV %: '),
                  Expanded(
                      child: TextFormField(
                    controller: customProbController,
                    decoration: const InputDecoration(suffixText: '%'),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ))
                ])
              ],
              if (hivstatusSelected == 'Unknown') ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Gender (Sex at birth): '),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: genderSelected,
                        hint: Text(genderSelected),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            genderSelected = value!;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            genderSelected = value!;
                          });
                        },
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Unknown",
                            child: Text("Unknown/Prefer not to say"),
                          ),
                          DropdownMenuItem(
                            value: "Male",
                            child: Text("Male (i.e. Cis-Male or Trans-Female)"),
                          ),
                          DropdownMenuItem(
                            value: "Female",
                            child:
                                Text("Female (i.e. Cis-Female or Trans-Male)"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Is your partner known to have sex with people who were born male?: ',
                      maxLines: 2,
                      softWrap: true,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: sexwithmenSelected,
                        hint: Text(sexwithmenSelected),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            sexwithmenSelected = value!;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            sexwithmenSelected = value!;
                          });
                        },
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Unknown",
                            child: Text("Unknown/Prefer not to say"),
                          ),
                          DropdownMenuItem(
                            value: "Yes",
                            child: Text("Yes"),
                          ),
                          DropdownMenuItem(
                            value: "No",
                            child: Text("No"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Ethnicity: '),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: ethnicitySelected,
                        hint: Text(ethnicitySelected),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            ethnicitySelected = value!;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            ethnicitySelected = value!;
                          });
                        },
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Unknown",
                            child: Text("Unknown/Prefer not to say"),
                          ),
                          DropdownMenuItem(
                            value: "Black",
                            child: Text("Black/African American"),
                          ),
                          DropdownMenuItem(
                            value: "Hispanic",
                            child: Text("Hispanic/Latino"),
                          ),
                          DropdownMenuItem(
                            value: "White",
                            child: Text("White/Caucasian"),
                          ),
                          DropdownMenuItem(
                            value: "Other",
                            child: Text("Other/Not Listed"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Known injection drug user?: '),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: injectorSelected,
                        hint: Text(injectorSelected),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            injectorSelected = value!;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            injectorSelected = value!;
                          });
                        },
                        items: const [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Unknown",
                            child: Text("Unknown/Prefer not to say"),
                          ),
                          DropdownMenuItem(
                            value: "Yes",
                            child: Text("Yes"),
                          ),
                          DropdownMenuItem(
                            value: "No",
                            child: Text("No"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 12,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('Exposure route(s) with partner: '),
                Expanded(
                    child: DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      exposureRoutesSelected = x;
                    });
                  },
                  options: const [
                    'Insertive Anal Intercourse (PAI)',
                    'Receptive Anal Intercourse (RAI)',
                    'Insertive Vaginal Intercourse (IVI)',
                    'Receptive Vaginal Intercourse (RVI)',
                    'Needle-sharing'
                  ],
                  selectedValues: exposureRoutesSelected,
                  whenEmpty: 'Select Exposure Route',
                ))
              ]),
              const SizedBox(
                height: 12,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('Protective measures used: '),
                Expanded(
                    child: DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      protectionSelected = x;
                    });
                  },
                  options: const [
                    'Condom',
                    'PrEP',
                    'ART+UVL',
                  ],
                  selectedValues: protectionSelected,
                  whenEmpty: 'Select Exposure Route',
                ))
              ]),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: const Color(0xff2da9ef),
            ),
            onPressed: () {
              print(hivstatusSelected);
              double prob = -1;
              if (hivstatusSelected == 'Custom') {
                prob = double.parse(customProbController.text) / 100;
              }
              model.add(Partner(
                  name: nameController.text,
                  hivProb: prob,
                  hivStatus: hivstatusSelected,
                  gender: genderSelected,
                  sexwithmen: sexwithmenSelected,
                  ethnicity: ethnicitySelected,
                  injector: injectorSelected,
                  routes: exposureRoutesSelected));
              Navigator.of(context).pop();
            },
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.nameController,
    required this.widget,
  });

  final TextEditingController nameController;
  final FormWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Name: '),
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.name,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T?)? onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
