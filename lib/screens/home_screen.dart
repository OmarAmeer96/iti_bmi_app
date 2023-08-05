import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_bmi_app/Language_cubit/cubit/language_cubit.dart';
import 'package:iti_bmi_app/cubit/cubit/bmi_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Method to calculate BMI
  void calculateBMI() {
    // Convert height from cm to meters
    double heightInMeters = height / 100;

    // Calculate BMI using the formula: BMI = weight (kg) / (height (m) * height (m))
    double bmiResult = weight / (heightInMeters * heightInMeters);

    // Update the bmi variable with the calculated value
    setState(() {
      bmi = bmiResult;
    });
    isBMICalculated = true;
  }

  bool isBMICalculated = false;
  String getBMIStatus() {
    if (bmi < 18.5) {
      return AppLocalizations.of(context)!.conditionOne;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return AppLocalizations.of(context)!.conditionTwo;
    } else if (bmi >= 25 && bmi <= 29.9) {
      return AppLocalizations.of(context)!.conditionThree;
    } else if (bmi >= 30 && bmi <= 34.9) {
      return AppLocalizations.of(context)!.conditionFour;
    } else if (bmi >= 35 && bmi <= 39.9) {
      return AppLocalizations.of(context)!.conditionFive;
    } else if (bmi == 0) {
      return "";
    } else {
      return AppLocalizations.of(context)!.conditionSix;
    }
  }

  double height = 0;
  int weight = 50;
  int age = 20;
  double bmi = 0;
  bool isDarkMode = true;
  void changeMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: isDarkMode
            ? const Color(0xff221e1c)
            : const Color.fromARGB(255, 238, 214, 214),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffae8c51),
          onPressed: () {
            launchUrlString(
              "tel: +201554111002",
            );
          },
          child: const Icon(
            Icons.call,
            size: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<BmiCubit, BmiState>(
                builder: (context, state) {
                  bool isMaleSelected = false;
                  bool isFemaleSelected = false;

                  if (state is GenderSelected) {
                    isMaleSelected = state.isMaleSelected;
                    isFemaleSelected = state.isFemaleSelected;
                  }

                  return Row(
                    children: [
                      _buildGenderContainer(
                        AppLocalizations.of(context)!.male,
                        Icons.male,
                        isMaleSelected,
                        () => context.read<BmiCubit>().selectMale(),
                      ),
                      const SizedBox(width: 10),
                      _buildGenderContainer(
                        AppLocalizations.of(context)!.female,
                        Icons.female,
                        isFemaleSelected,
                        () => context.read<BmiCubit>().selectFemale(),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.height,
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        height.toStringAsFixed(0),
                        style: const TextStyle(
                          fontFamily: "Gilroy-Heavy",
                          color: Color(0xffA97C37),
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.cm,
                        style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: height,
                    onChanged: (newValue) {
                      setState(() {
                        height = newValue;
                      });
                    },
                    min: 0.0,
                    max: 250.0,
                    divisions: 250,
                    thumbColor: const Color(0xff55433C),
                    activeColor: const Color(0xffA97C37),
                    inactiveColor: const Color.fromRGBO(97, 98, 113, 1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        m2Expanded(context, 'age'),
                        const SizedBox(
                          width: 20,
                        ),
                        m2Expanded(context, 'weight'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        calculateBMI(); // Call the method to calculate BMI when the button is tapped
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff55433C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.calc,
                            style: const TextStyle(
                              fontFamily: "Gilroy-Bold",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.result,
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xff606271).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          bmi.toStringAsFixed(2),
                          style: TextStyle(
                            fontFamily: "Gilroy-Heavy",
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xff55423d),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  isBMICalculated
                      ? DottedBorder(
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xff55423d),
                          strokeWidth: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isBMICalculated
                                        ? Text(
                                            AppLocalizations.of(context)!
                                                .youAre,
                                            style: TextStyle(
                                              fontFamily: "Gilroy-Bold",
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20,
                                            ),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                              fontFamily: "Gilroy-Bold",
                                              color: Color(0xffA97C37),
                                              fontSize: 20,
                                            ),
                                          ),
                                    isBMICalculated
                                        ? Text(
                                            getBMIStatus(),
                                            style: const TextStyle(
                                              fontFamily: "Gilroy-Heavy",
                                              color: Color(0xffA97C37),
                                              fontSize: 20,
                                            ),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                              fontFamily: "Gilroy-Bold",
                                              color: Color(0xffA97C37),
                                              fontSize: 20,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text(""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderContainer(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final backgroundColor = isSelected
        ? const Color(0xff55433C)
        : (isDarkMode ? const Color(0xff272220) : const Color(0xff5a5f6d));
    final borderColor =
        isSelected ? const Color(0xffA97C37) : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 185,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: const Color(0xffA97C37),
                  size: 60,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Gilroy-Bold",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.appBar,
        style: TextStyle(
          fontFamily: "Gilroy-Bold",
          fontSize: 25,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: isDarkMode ? const Color(0xff221e1c) : Colors.grey,
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            changeMode();
          },
          icon: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<LanguageCubit>().changeLanguage();
          },
          icon: Icon(
            Icons.language,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            // Web View
            launchUrlString(
              "https://facebook.com",
              // I don't know what does this line do
              mode: LaunchMode.externalNonBrowserApplication,
            );
          },
          icon: Icon(
            Icons.web,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode ? const Color(0xff272220) : const Color(0xff5a5f6d),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == 'weight'
                  ? AppLocalizations.of(context)!.weight
                  : AppLocalizations.of(context)!.age,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Gilroy-Bold",
              ),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  type == 'age' ? '$age' : '$weight',
                  style: const TextStyle(
                    color: Color(0xffA97C37),
                    fontSize: 25,
                    fontFamily: "Gilroy-Heavy",
                  ),
                ),
                Text(
                  type == 'weight' ? AppLocalizations.of(context)!.kg : '',
                  style: const TextStyle(
                    color: Color(0xffA97C37),
                    fontSize: 25,
                    fontFamily: "Gilroy-Heavy",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                  onPressed: () =>
                      setState(() => type == 'age' ? age-- : weight--),
                  mini: true,
                  backgroundColor: const Color(0xff55433C),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                  onPressed: () =>
                      setState(() => type == 'age' ? age++ : weight++),
                  mini: true,
                  backgroundColor: const Color(0xff55433C),
                  child: const Icon(Icons.add),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
