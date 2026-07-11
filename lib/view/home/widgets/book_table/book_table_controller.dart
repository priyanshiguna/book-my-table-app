import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BookTableController extends GetxController {
  final RxInt selectedYear = 2026.obs;
  final RxInt selectedMonth = 1.obs; // 1 = Jan
  final RxInt selectedDay = 16.obs;

  final RxInt selectedHour = 11.obs;
  final RxInt selectedMinute = 12.obs;
  final RxString selectedPeriod = "AM".obs;

  final RxInt guestCount = 4.obs;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  final List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  final List<int> years = List.generate(10, (index) => 2026 + index);

  @override
  void onInit() {
    super.onInit();
    // 11 is index 10 (since 1 is index 0)
    hourController = FixedExtentScrollController(initialItem: 10);
    // 12 is index 12 (since 0 is index 0)
    minuteController = FixedExtentScrollController(initialItem: 12);
    // AM is index 0
    periodController = FixedExtentScrollController(initialItem: 0);

    selectedYear.value = DateTime.now().year;
    selectedMonth.value = DateTime.now().month;
    selectedDay.value = DateTime.now().day;
    years.assignAll(List.generate(10, (index) => DateTime.now().year + index));
  }

  @override
  void onClose() {
    hourController.dispose();
    minuteController.dispose();
    periodController.dispose();
    super.onClose();
  }

  String get selectedMonthName => monthNames[selectedMonth.value - 1];

  int get daysInMonth => DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;

  int get startPadding => DateTime(selectedYear.value, selectedMonth.value, 1).weekday % 7;

  int get totalPrice => guestCount.value * 12 + 1;

  void selectDay(int day) {
    if (day >= 1 && day <= daysInMonth) {
      selectedDay.value = day;
    }
  }

  void incrementGuests() {
    guestCount.value++;
  }

  void decrementGuests() {
    if (guestCount.value > 1) {
      guestCount.value--;
    }
  }

  void updateMonth(int month) {
    selectedMonth.value = month;
    // Keep day in range of selected month
    if (selectedDay.value > daysInMonth) {
      selectedDay.value = daysInMonth;
    }
  }

  void updateYear(int year) {
    selectedYear.value = year;
    // Keep day in range of selected month/year
    if (selectedDay.value > daysInMonth) {
      selectedDay.value = daysInMonth;
    }
  }
}
