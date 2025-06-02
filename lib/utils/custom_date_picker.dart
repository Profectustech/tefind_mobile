import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:te_find/app/widgets/custom_button.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:te_find/utils/date_grouping.dart';
import 'package:te_find/utils/screen_size.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../utils/locator.dart';

class CustomDateRangePicker extends StatefulWidget {
  final Function(DateTime?, DateTime?) onApplyClick;
  const CustomDateRangePicker({Key? key, required this.onApplyClick})
      : super(key: key);

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  final NavigatorService _navigationService = locator<NavigatorService>();
  final pageController = PageController();
  String selectedFilter = "daily";
  bool isStartDateSelected = false;
  bool isStartMonthSelected = false;
  DateTime? _dailyStartDate;
  DateTime? _monthlyStartDate;
  final DateRangePickerController _dailyController =
      DateRangePickerController();
  final DateRangePickerController _monthlyController =
      DateRangePickerController();
  final DateRangePickerController _yearlyController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = Responsive.height(context);
    final double sWidth = Responsive.width(context);
    return SizedBox(
        height: sHeight * 0.8,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        _navigationService.goBack();
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Date Filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff083A50),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 44,
                      width: 250,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greenSecond,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedFilter = "daily";
                                });
                                pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut);
                                monthlyReset();
                                yearlyReset();
                              },
                              child: Container(
                                height: 37,
                                // width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedFilter == "daily"
                                      ? AppColors.white
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "DAILY",
                                  style: TextStyle(
                                      color: selectedFilter == "daily"
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedFilter = "monthly";
                                });
                                pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut);
                                dailyReset();
                                yearlyReset();
                              },
                              child: Container(
                                height: 37,
                                // width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedFilter == "monthly"
                                      ? AppColors.white
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "MONTHLY",
                                  style: TextStyle(
                                      color: selectedFilter == "monthly"
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedFilter = "yearly";
                                });
                                pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut);
                                dailyReset();
                                monthlyReset();
                              },
                              child: Container(
                                height: 37,
                                // width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedFilter == "yearly"
                                      ? AppColors.white
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "YEARLY",
                                  style: TextStyle(
                                      color: selectedFilter == "yearly"
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 400,
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          // height:400,
                          width: sWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      _dailyController.selectedRange == null
                                          ? "No range selected"
                                          : (_dailyController.selectedRange!
                                                          .startDate !=
                                                      null &&
                                                  _dailyController
                                                          .selectedRange!
                                                          .endDate !=
                                                      null)
                                              ? "${shortDate4(_dailyController.selectedRange!.startDate!.toIso8601String())} "
                                                  "- ${shortDate4(_dailyController.selectedRange!.endDate!.toIso8601String())}"
                                              : "No range selected",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  TextButton(
                                      onPressed: dailyReset,
                                      child: const Text(
                                        "Reset",
                                        style: TextStyle(
                                            color: AppColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ))
                                ],
                              ),
                              Divider(
                                color: AppColors.grey,
                                thickness: 0.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SfDateRangePicker(
                                  backgroundColor: Colors.white,
                                  view: DateRangePickerView.month,
                                  controller: _dailyController,
                                  maxDate: DateTime.now(),
                                  todayHighlightColor: AppColors.primaryColor,
                                  selectionColor: AppColors.primaryColor,
                                  monthCellStyle:
                                      const DateRangePickerMonthCellStyle(
                                          todayTextStyle: TextStyle(
                                              color: AppColors.primaryColor)),
                                  selectableDayPredicate: (DateTime date) {
                                    // Disable selection of days that are not in the initial date month
                                    return isStartDateSelected
                                        ? date.month ==
                                                _dailyStartDate?.month &&
                                            date.year == _dailyStartDate?.year
                                        : true;
                                  },
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  startRangeSelectionColor:
                                      AppColors.primaryColor,
                                  endRangeSelectionColor:
                                      AppColors.primaryColor,
                                  rangeSelectionColor:
                                      AppColors.primaryColor.withOpacity(0.3),
                                  onSelectionChanged:
                                      (DateRangePickerSelectionChangedArgs?
                                          args) {
                                    if (args?.value?.startDate != null) {
                                      setState(() {
                                        isStartDateSelected = true;
                                        _dailyStartDate =
                                            args?.value?.startDate;
                                      });
                                    } else {
                                      setState(() {
                                        isStartDateSelected = false;
                                      });
                                    }
                                    // setState(() {
                                    //   _dailyController.selectedRange = PickerDateRange(args.value.startDate, args.value.endDate);
                                    // });
                                    // setState(() {
                                    //   _startDate = args.value.startDate;
                                    //   _endDate = args.value.endDate;
                                    // });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height:400,
                          width: sWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      _monthlyController.selectedRange == null
                                          ? "No range selected"
                                          : (_monthlyController.selectedRange!
                                                          .startDate !=
                                                      null &&
                                                  _monthlyController
                                                          .selectedRange!
                                                          .endDate !=
                                                      null)
                                              ? "${shortDate5(_monthlyController.selectedRange!.startDate!.toIso8601String())} "
                                                  "- ${shortDate5(_monthlyController.selectedRange!.endDate!.toIso8601String())}"
                                              : "No range selected",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                  TextButton(
                                      onPressed: monthlyReset,
                                      child: const Text(
                                        "Reset",
                                        style: TextStyle(
                                            color: AppColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ))
                                ],
                              ),
                              Divider(
                                color: AppColors.grey,
                                thickness: 0.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SfDateRangePicker(
                                  backgroundColor: Colors.white,
                                  view: DateRangePickerView.year,
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  todayHighlightColor: AppColors.primaryColor,
                                  controller: _monthlyController,
                                  yearCellStyle:
                                      const DateRangePickerYearCellStyle(
                                    todayTextStyle: TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                  maxDate: DateTime.now(),
                                  selectableDayPredicate: (DateTime date) {
                                    // Disable selection of months that are not in the initial date year
                                    return isStartMonthSelected
                                        ? date.year == _monthlyStartDate?.year
                                        : true;
                                  },
                                  enablePastDates: true,
                                  showNavigationArrow: true,
                                  allowViewNavigation: false,
                                  navigationMode:
                                      DateRangePickerNavigationMode.none,
                                  rangeSelectionColor:
                                      AppColors.primaryColor.withOpacity(0.3),
                                  startRangeSelectionColor:
                                      AppColors.primaryColor,
                                  endRangeSelectionColor:
                                      AppColors.primaryColor,
                                  onSelectionChanged:
                                      (DateRangePickerSelectionChangedArgs?
                                          args) {
                                    if (args?.value?.startDate != null) {
                                      setState(() {
                                        isStartMonthSelected = true;
                                        _monthlyStartDate =
                                            args?.value?.startDate;
                                      });
                                    } else {
                                      setState(() {
                                        isStartMonthSelected = false;
                                      });
                                    }
                                    // setState(() {
                                    //
                                    // });
                                    if (args?.value is PickerDateRange) {}
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height:400,
                          width: sWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      _yearlyController.selectedRange == null
                                          ? "No range selected"
                                          : (_yearlyController.selectedRange
                                                          ?.startDate !=
                                                      null &&
                                                  _yearlyController
                                                          .selectedRange
                                                          ?.endDate !=
                                                      null)
                                              ? "${shortDate6(_yearlyController.selectedRange!.startDate!.toIso8601String())} "
                                                  "- ${shortDate6(_yearlyController.selectedRange!.endDate!.toIso8601String())}"
                                              : "No range selected",
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                  TextButton(
                                      onPressed: yearlyReset,
                                      child: const Text(
                                        "Reset",
                                        style: TextStyle(
                                            color: AppColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ))
                                ],
                              ),
                              Divider(
                                color: AppColors.grey,
                                thickness: 0.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SfDateRangePicker(
                                  backgroundColor: AppColors.white,
                                  view: DateRangePickerView.decade,
                                  controller: _yearlyController,
                                  yearCellStyle:
                                      const DateRangePickerYearCellStyle(
                                          todayTextStyle: TextStyle(
                                              color: AppColors.primaryColor)),
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  todayHighlightColor: AppColors.primaryColor,
                                  startRangeSelectionColor:
                                      AppColors.greenSecond,
                                  endRangeSelectionColor: AppColors.greenSecond,
                                  maxDate: DateTime.now(),
                                  rangeSelectionColor:
                                      AppColors.primaryColor.withOpacity(0.3),
                                  showNavigationArrow: true,
                                  allowViewNavigation: false,
                                  onSelectionChanged:
                                      (DateRangePickerSelectionChangedArgs
                                          args) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: CustomButton(
                        onPressed:
                            ((_dailyController.selectedRange?.startDate !=
                                            null &&
                                        _dailyController
                                                .selectedRange?.endDate !=
                                            null) ||
                                    (_monthlyController
                                                .selectedRange?.startDate !=
                                            null &&
                                        _monthlyController
                                                .selectedRange?.endDate !=
                                            null) ||
                                    (_yearlyController
                                                .selectedRange?.startDate !=
                                            null &&
                                        _yearlyController
                                                .selectedRange?.endDate !=
                                            null))
                                ? () {
                                    if (selectedFilter == "daily") {
                                      if (kDebugMode) {
                                        print("daily applied");
                                      }
                                      widget.onApplyClick(
                                          _dailyController
                                              .selectedRange?.startDate,
                                          _dailyController
                                              .selectedRange?.endDate);
                                    } else if (selectedFilter == "monthly") {
                                      if (kDebugMode) {
                                        print("monthly applied");
                                      }
                                      widget.onApplyClick(
                                          _monthlyController
                                              .selectedRange?.startDate,
                                          _monthlyController
                                              .selectedRange?.endDate);
                                    } else {
                                      if (kDebugMode) {
                                        print("yearly applied");
                                      }
                                      widget.onApplyClick(
                                          _yearlyController
                                              .selectedRange?.startDate,
                                          _yearlyController
                                              .selectedRange?.endDate);
                                    }
                                  }
                                : null,
                        label: 'Apply',
                      )),
                  const Center(
                    child: Text(
                      "Kindly select two options to create a range",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ])));
  }

  void dailyReset() {
    _dailyController.displayDate = DateTime.now();
    _dailyController.selectedRange = null;
    _dailyController.view = DateRangePickerView.month;
  }

  void monthlyReset() {
    _monthlyController.displayDate = DateTime.now();
    _monthlyController.selectedRange = null;
    _monthlyController.view = DateRangePickerView.year;
  }

  void yearlyReset() {
    _yearlyController.displayDate = DateTime.now();
    _yearlyController.selectedRange = null;
    _yearlyController.view = DateRangePickerView.decade;
  }

  List<DateTime> _getSelectedMonths(PickerDateRange? dateRange) {
    List<DateTime> selectedMonths = [];

    DateTime startMonth = DateTime(
        dateRange?.startDate?.year ?? DateTime.now().year,
        dateRange?.startDate?.month ?? DateTime.now().month);
    DateTime endMonth = DateTime(
        dateRange?.endDate?.year ?? DateTime.now().year,
        dateRange?.endDate?.month ?? DateTime.now().month);

    for (DateTime month = startMonth;
        month.isBefore(endMonth) || month == endMonth;
        month = month.add(const Duration(days: 31))) {
      selectedMonths.add(month);
    }

    return selectedMonths;
  }
}
