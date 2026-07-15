// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(budget) => "هدف الميزانية: ${budget}";

  static String m1(count) =>
      "${Intl.plural(count, zero: '٠ فئة', one: 'فئة واحدة', two: 'فئتان', few: '${count} فئات', many: '${count} فئة', other: '${count} فئة')}";

  static String m2(name) => "لا يوجد مسار محدد لـ ${name}";

  static String m3(budget) => "الميزانية الكلية: ${budget}";

  static String m4(count) =>
      "${Intl.plural(count, zero: '٠ معاملة', one: 'معاملة واحدة', two: 'معاملتان', few: '${count} معاملات', many: '${count} معاملة', other: '${count} معاملة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addExpense": MessageLookupByLibrary.simpleMessage("إضافة مصروف"),
    "addNoteOptional": MessageLookupByLibrary.simpleMessage(
      "إضافة ملاحظة (اختياري)",
    ),
    "addTask": MessageLookupByLibrary.simpleMessage("إضافة مهمة"),
    "allTimeSpent": MessageLookupByLibrary.simpleMessage("إجمالي الإنفاق"),
    "amount": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Walletix"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "avgPerMonth": MessageLookupByLibrary.simpleMessage("متوسط شهري"),
    "back": MessageLookupByLibrary.simpleMessage("رجوع"),
    "bills": MessageLookupByLibrary.simpleMessage("فواتير"),
    "budgetGoal": m0,
    "budgetSettings": MessageLookupByLibrary.simpleMessage("إعدادات الميزانية"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "categories": MessageLookupByLibrary.simpleMessage("الفئات"),
    "categoriesCount": m1,
    "categorySingular": MessageLookupByLibrary.simpleMessage("الفئة"),
    "clearAllExpenses": MessageLookupByLibrary.simpleMessage(
      "مسح جميع النفقات",
    ),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("الحالية: العربية"),
    "currentMonth": MessageLookupByLibrary.simpleMessage("الشهر الحالي"),
    "daily": MessageLookupByLibrary.simpleMessage("يومي"),
    "dailyAvg": MessageLookupByLibrary.simpleMessage("المتوسط اليومي"),
    "date": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteTask": MessageLookupByLibrary.simpleMessage("حذف المهمة"),
    "description": MessageLookupByLibrary.simpleMessage("الوصف"),
    "details": MessageLookupByLibrary.simpleMessage("التفاصيل"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editTask": MessageLookupByLibrary.simpleMessage("تعديل المهمة"),
    "editTransaction": MessageLookupByLibrary.simpleMessage("تعديل المعاملة"),
    "education": MessageLookupByLibrary.simpleMessage("تعليم"),
    "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "entertainment": MessageLookupByLibrary.simpleMessage("ترفيه"),
    "food": MessageLookupByLibrary.simpleMessage("طعام"),
    "general": MessageLookupByLibrary.simpleMessage("تفضيلات عامة"),
    "getStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
    "health": MessageLookupByLibrary.simpleMessage("صحة"),
    "high": MessageLookupByLibrary.simpleMessage("عالية"),
    "highestSpending": MessageLookupByLibrary.simpleMessage("أعلى إنفاق"),
    "history": MessageLookupByLibrary.simpleMessage("السجل"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "lastMonths": MessageLookupByLibrary.simpleMessage("الأشهر الماضية"),
    "live": MessageLookupByLibrary.simpleMessage("مباشر"),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "low": MessageLookupByLibrary.simpleMessage("منخفضة"),
    "markAsCompleted": MessageLookupByLibrary.simpleMessage("تحديد كمكتمل"),
    "medium": MessageLookupByLibrary.simpleMessage("متوسطة"),
    "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
    "monthlyBudget": MessageLookupByLibrary.simpleMessage("الميزانية الشهرية"),
    "monthlySpendingReport": MessageLookupByLibrary.simpleMessage(
      "تقرير الإنفاق الشهري",
    ),
    "monthlySummary": MessageLookupByLibrary.simpleMessage("الملخص الشهري"),
    "months": MessageLookupByLibrary.simpleMessage("الشهور"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noExpensesYet": MessageLookupByLibrary.simpleMessage("لا توجد نفقات بعد."),
    "noNote": MessageLookupByLibrary.simpleMessage("بدون ملاحظة"),
    "noRouteDefined": m2,
    "noSummariesYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد ملخصات شهرية بعد.\nأضف نفقات للبدء!",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("لا توجد مهام لهذا اليوم"),
    "noTransactionsRecent": MessageLookupByLibrary.simpleMessage(
      "لا توجد معاملات حديثة هنا",
    ),
    "noTransactionsYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد معاملات بعد.\nأضف واحدة لتتبع إنفاقك!",
    ),
    "none": MessageLookupByLibrary.simpleMessage("لا يوجد"),
    "note": MessageLookupByLibrary.simpleMessage("ملاحظة"),
    "noteHint": MessageLookupByLibrary.simpleMessage("أضف بعض الملاحظات"),
    "ofBudget": MessageLookupByLibrary.simpleMessage("من الميزانية"),
    "other": MessageLookupByLibrary.simpleMessage("أخرى"),
    "overBudget": MessageLookupByLibrary.simpleMessage("تجاوز الميزانية"),
    "pleaseEnterValidAmount": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال مبلغ صحيح",
    ),
    "pleaseSelectCategory": MessageLookupByLibrary.simpleMessage(
      "الرجاء اختيار فئة",
    ),
    "priority": MessageLookupByLibrary.simpleMessage("الأولوية"),
    "profile": MessageLookupByLibrary.simpleMessage("الحساب"),
    "recentTransactions": MessageLookupByLibrary.simpleMessage(
      "المعاملات الأخيرة",
    ),
    "refresh": MessageLookupByLibrary.simpleMessage("تحديث"),
    "remainingBalance": MessageLookupByLibrary.simpleMessage("الرصيد المتبقي"),
    "rememberMe": MessageLookupByLibrary.simpleMessage("تذكرني"),
    "rememberMeDescription": MessageLookupByLibrary.simpleMessage(
      "إشعارات لتذكيرات المهام",
    ),
    "report": MessageLookupByLibrary.simpleMessage("التقارير"),
    "resetMonth": MessageLookupByLibrary.simpleMessage("إعادة تعيين الشهر"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "seeAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "selectCategory": MessageLookupByLibrary.simpleMessage("اختر الفئة"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "shopping": MessageLookupByLibrary.simpleMessage("تسوق"),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "spendingBreakdown": MessageLookupByLibrary.simpleMessage("تفاصيل الإنفاق"),
    "spendingChart": MessageLookupByLibrary.simpleMessage("مخطط الإنفاق"),
    "states": MessageLookupByLibrary.simpleMessage("الحالات"),
    "taskCompleted": MessageLookupByLibrary.simpleMessage("المهمة اكتملت"),
    "thisMonth": MessageLookupByLibrary.simpleMessage("هذا الشهر"),
    "thisWeek": MessageLookupByLibrary.simpleMessage("هذا الأسبوع"),
    "time": MessageLookupByLibrary.simpleMessage("الوقت"),
    "title": MessageLookupByLibrary.simpleMessage("العنوان"),
    "titleRequired": MessageLookupByLibrary.simpleMessage("العنوان مطلوب"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "top": MessageLookupByLibrary.simpleMessage("الأعلى"),
    "topCategory": MessageLookupByLibrary.simpleMessage("أعلى فئة"),
    "total": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "totalBudget": m3,
    "totalSpending": MessageLookupByLibrary.simpleMessage("إجمالي الإنفاق"),
    "totalSpendingCap": MessageLookupByLibrary.simpleMessage("إجمالي الإنفاق"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("إجمالي المنفق"),
    "transactions": MessageLookupByLibrary.simpleMessage("المعاملات"),
    "transactionsCount": m4,
    "transport": MessageLookupByLibrary.simpleMessage("نقل"),
    "underBudget": MessageLookupByLibrary.simpleMessage("ضمن الميزانية"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
    "viewPastSpending": MessageLookupByLibrary.simpleMessage(
      "عرض سجل الإنفاق السابق",
    ),
    "weekly": MessageLookupByLibrary.simpleMessage("أسبوعي"),
    "welcomeDesc1": MessageLookupByLibrary.simpleMessage(
      "القطعة القياسية من لوريم إيبسوم المستخدمة منذ القرن السادس عشر مستنسخة أدناه للمهتمين.",
    ),
    "welcomeDesc2": MessageLookupByLibrary.simpleMessage(
      "لقد نجت ليس فقط خمسة قرون، بل أيضا قفزة إلى التنضيد الإلكتروني.",
    ),
    "welcomeDesc3": MessageLookupByLibrary.simpleMessage(
      "خلافا للاعتقاد السائد، لوريم إيبسوم ليس ببساطة نصا عشوائيا. له جذور في قطعة من الأدب الكلاسيكي.",
    ),
    "welcomeTitle1": MessageLookupByLibrary.simpleMessage("تتبع فواتيرك"),
    "welcomeTitle2": MessageLookupByLibrary.simpleMessage("استثمارات ذكية"),
    "welcomeTitle3": MessageLookupByLibrary.simpleMessage("حقق أهدافك"),
    "yourSpendingLimit": MessageLookupByLibrary.simpleMessage(
      "حد الإنفاق الخاص بك",
    ),
  };
}
