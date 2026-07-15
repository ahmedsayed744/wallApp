// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(budget) => "Budget Goal: ${budget}";

  static String m1(count) =>
      "${Intl.plural(count, one: '1 category', other: '${count} categories')}";

  static String m2(name) => "No route defined for ${name}";

  static String m3(budget) => "Total Budget: ${budget}";

  static String m4(count) =>
      "${Intl.plural(count, one: '1 transaction', other: '${count} transactions')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addExpense": MessageLookupByLibrary.simpleMessage("Add Expense"),
    "addNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Add Note (Optional)",
    ),
    "addTask": MessageLookupByLibrary.simpleMessage("Add Task"),
    "allTimeSpent": MessageLookupByLibrary.simpleMessage("All-time Spent"),
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Walletix"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "avgPerMonth": MessageLookupByLibrary.simpleMessage("Avg / Month"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "bills": MessageLookupByLibrary.simpleMessage("Bills"),
    "budgetGoal": m0,
    "budgetSettings": MessageLookupByLibrary.simpleMessage("Budget Settings"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoriesCount": m1,
    "categorySingular": MessageLookupByLibrary.simpleMessage("Category"),
    "clearAllExpenses": MessageLookupByLibrary.simpleMessage(
      "Clear all expenses",
    ),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("Current: English"),
    "currentMonth": MessageLookupByLibrary.simpleMessage("Current Month"),
    "daily": MessageLookupByLibrary.simpleMessage("Daily"),
    "dailyAvg": MessageLookupByLibrary.simpleMessage("Daily Avg"),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteTask": MessageLookupByLibrary.simpleMessage("Delete Task"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editTask": MessageLookupByLibrary.simpleMessage("Edit Task"),
    "editTransaction": MessageLookupByLibrary.simpleMessage("Edit Transaction"),
    "education": MessageLookupByLibrary.simpleMessage("Education"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "entertainment": MessageLookupByLibrary.simpleMessage("Entertainment"),
    "food": MessageLookupByLibrary.simpleMessage("Food"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "health": MessageLookupByLibrary.simpleMessage("Health"),
    "high": MessageLookupByLibrary.simpleMessage("High"),
    "highestSpending": MessageLookupByLibrary.simpleMessage("Highest Spending"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "lastMonths": MessageLookupByLibrary.simpleMessage("Last Months"),
    "live": MessageLookupByLibrary.simpleMessage("Live"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "low": MessageLookupByLibrary.simpleMessage("Low"),
    "markAsCompleted": MessageLookupByLibrary.simpleMessage(
      "Mark as Completed",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("Medium"),
    "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "monthlyBudget": MessageLookupByLibrary.simpleMessage("Monthly Budget"),
    "monthlySpendingReport": MessageLookupByLibrary.simpleMessage(
      "Monthly Spending Report",
    ),
    "monthlySummary": MessageLookupByLibrary.simpleMessage("Monthly Summary"),
    "months": MessageLookupByLibrary.simpleMessage("Months"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noExpensesYet": MessageLookupByLibrary.simpleMessage("No expenses yet."),
    "noNote": MessageLookupByLibrary.simpleMessage("No note"),
    "noRouteDefined": m2,
    "noSummariesYet": MessageLookupByLibrary.simpleMessage(
      "No monthly summaries yet.\nAdd expenses to get started!",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("No tasks for this day"),
    "noTransactionsRecent": MessageLookupByLibrary.simpleMessage(
      "There\'s no recent transactions here",
    ),
    "noTransactionsYet": MessageLookupByLibrary.simpleMessage(
      "No transactions yet.\nAdd one to track your spending!",
    ),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "note": MessageLookupByLibrary.simpleMessage("Note"),
    "noteHint": MessageLookupByLibrary.simpleMessage("Add some note"),
    "ofBudget": MessageLookupByLibrary.simpleMessage("of budget"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "overBudget": MessageLookupByLibrary.simpleMessage("Over budget"),
    "pleaseEnterValidAmount": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid amount",
    ),
    "pleaseSelectCategory": MessageLookupByLibrary.simpleMessage(
      "Please select a category",
    ),
    "priority": MessageLookupByLibrary.simpleMessage("Priority"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "recentTransactions": MessageLookupByLibrary.simpleMessage(
      "Recent Transactions",
    ),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "remainingBalance": MessageLookupByLibrary.simpleMessage(
      "Remaining Balance",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember Me"),
    "rememberMeDescription": MessageLookupByLibrary.simpleMessage(
      "Notifications for task reminders",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Report"),
    "resetMonth": MessageLookupByLibrary.simpleMessage("Reset Month"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See All"),
    "selectCategory": MessageLookupByLibrary.simpleMessage("Select Category"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "shopping": MessageLookupByLibrary.simpleMessage("Shopping"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "spendingBreakdown": MessageLookupByLibrary.simpleMessage(
      "Spending Breakdown",
    ),
    "spendingChart": MessageLookupByLibrary.simpleMessage("Spending Chart"),
    "states": MessageLookupByLibrary.simpleMessage("States"),
    "taskCompleted": MessageLookupByLibrary.simpleMessage("Task Completed"),
    "thisMonth": MessageLookupByLibrary.simpleMessage("This Month"),
    "thisWeek": MessageLookupByLibrary.simpleMessage("This Week"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "title": MessageLookupByLibrary.simpleMessage("Title"),
    "titleRequired": MessageLookupByLibrary.simpleMessage("Title is required"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "top": MessageLookupByLibrary.simpleMessage("Top"),
    "topCategory": MessageLookupByLibrary.simpleMessage("Top Category"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalBudget": m3,
    "totalSpending": MessageLookupByLibrary.simpleMessage("Total Spending"),
    "totalSpendingCap": MessageLookupByLibrary.simpleMessage("TOTAL SPENDING"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("Total Spent"),
    "transactions": MessageLookupByLibrary.simpleMessage("Transactions"),
    "transactionsCount": m4,
    "transport": MessageLookupByLibrary.simpleMessage("Transport"),
    "underBudget": MessageLookupByLibrary.simpleMessage("Under budget"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewPastSpending": MessageLookupByLibrary.simpleMessage(
      "View past spending history",
    ),
    "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "welcomeDesc1": MessageLookupByLibrary.simpleMessage(
      "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.",
    ),
    "welcomeDesc2": MessageLookupByLibrary.simpleMessage(
      "It has survived not only five centuries, but also the leap into electronic typesetting.",
    ),
    "welcomeDesc3": MessageLookupByLibrary.simpleMessage(
      "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin.",
    ),
    "welcomeTitle1": MessageLookupByLibrary.simpleMessage("Track Your Bills"),
    "welcomeTitle2": MessageLookupByLibrary.simpleMessage("Smart Investments"),
    "welcomeTitle3": MessageLookupByLibrary.simpleMessage("Reach Your Goals"),
    "yourSpendingLimit": MessageLookupByLibrary.simpleMessage(
      "Your spending limit",
    ),
  };
}
