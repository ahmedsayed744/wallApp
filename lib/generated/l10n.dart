// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Walletix`
  String get appTitle {
    return Intl.message('Walletix', name: 'appTitle', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Current: English`
  String get currentLanguage {
    return Intl.message(
      'Current: English',
      name: 'currentLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Please enter a valid amount`
  String get pleaseEnterValidAmount {
    return Intl.message(
      'Please enter a valid amount',
      name: 'pleaseEnterValidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get pleaseSelectCategory {
    return Intl.message(
      'Please select a category',
      name: 'pleaseSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message('Add Expense', name: 'addExpense', desc: '', args: []);
  }

  /// `Recent Transactions`
  String get recentTransactions {
    return Intl.message(
      'Recent Transactions',
      name: 'recentTransactions',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `There's no recent transactions here`
  String get noTransactionsRecent {
    return Intl.message(
      'There\'s no recent transactions here',
      name: 'noTransactionsRecent',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Balance`
  String get remainingBalance {
    return Intl.message(
      'Remaining Balance',
      name: 'remainingBalance',
      desc: '',
      args: [],
    );
  }

  /// `Total Budget: {budget}`
  String totalBudget(String budget) {
    return Intl.message(
      'Total Budget: $budget',
      name: 'totalBudget',
      desc: '',
      args: [budget],
    );
  }

  /// `States`
  String get states {
    return Intl.message('States', name: 'states', desc: '', args: []);
  }

  /// `Budget Settings`
  String get budgetSettings {
    return Intl.message(
      'Budget Settings',
      name: 'budgetSettings',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Budget`
  String get monthlyBudget {
    return Intl.message(
      'Monthly Budget',
      name: 'monthlyBudget',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Total Spending`
  String get totalSpending {
    return Intl.message(
      'Total Spending',
      name: 'totalSpending',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `No transactions yet.\nAdd one to track your spending!`
  String get noTransactionsYet {
    return Intl.message(
      'No transactions yet.\nAdd one to track your spending!',
      name: 'noTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Track Your Bills`
  String get welcomeTitle1 {
    return Intl.message(
      'Track Your Bills',
      name: 'welcomeTitle1',
      desc: '',
      args: [],
    );
  }

  /// `The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.`
  String get welcomeDesc1 {
    return Intl.message(
      'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.',
      name: 'welcomeDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Smart Investments`
  String get welcomeTitle2 {
    return Intl.message(
      'Smart Investments',
      name: 'welcomeTitle2',
      desc: '',
      args: [],
    );
  }

  /// `It has survived not only five centuries, but also the leap into electronic typesetting.`
  String get welcomeDesc2 {
    return Intl.message(
      'It has survived not only five centuries, but also the leap into electronic typesetting.',
      name: 'welcomeDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Reach Your Goals`
  String get welcomeTitle3 {
    return Intl.message(
      'Reach Your Goals',
      name: 'welcomeTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin.`
  String get welcomeDesc3 {
    return Intl.message(
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin.',
      name: 'welcomeDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Note (Optional)`
  String get addNoteOptional {
    return Intl.message(
      'Add Note (Optional)',
      name: 'addNoteOptional',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Spending Report`
  String get monthlySpendingReport {
    return Intl.message(
      'Monthly Spending Report',
      name: 'monthlySpendingReport',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL SPENDING`
  String get totalSpendingCap {
    return Intl.message(
      'TOTAL SPENDING',
      name: 'totalSpendingCap',
      desc: '',
      args: [],
    );
  }

  /// `Over budget`
  String get overBudget {
    return Intl.message('Over budget', name: 'overBudget', desc: '', args: []);
  }

  /// `Under budget`
  String get underBudget {
    return Intl.message(
      'Under budget',
      name: 'underBudget',
      desc: '',
      args: [],
    );
  }

  /// `Budget Goal: {budget}`
  String budgetGoal(String budget) {
    return Intl.message(
      'Budget Goal: $budget',
      name: 'budgetGoal',
      desc: '',
      args: [budget],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `No expenses yet.`
  String get noExpensesYet {
    return Intl.message(
      'No expenses yet.',
      name: 'noExpensesYet',
      desc: '',
      args: [],
    );
  }

  /// `Daily Avg`
  String get dailyAvg {
    return Intl.message('Daily Avg', name: 'dailyAvg', desc: '', args: []);
  }

  /// `Top Category`
  String get topCategory {
    return Intl.message(
      'Top Category',
      name: 'topCategory',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message('Food', name: 'food', desc: '', args: []);
  }

  /// `Transport`
  String get transport {
    return Intl.message('Transport', name: 'transport', desc: '', args: []);
  }

  /// `Shopping`
  String get shopping {
    return Intl.message('Shopping', name: 'shopping', desc: '', args: []);
  }

  /// `Bills`
  String get bills {
    return Intl.message('Bills', name: 'bills', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Entertainment`
  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message('Education', name: 'education', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Your spending limit`
  String get yourSpendingLimit {
    return Intl.message(
      'Your spending limit',
      name: 'yourSpendingLimit',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Reset Month`
  String get resetMonth {
    return Intl.message('Reset Month', name: 'resetMonth', desc: '', args: []);
  }

  /// `Clear all expenses`
  String get clearAllExpenses {
    return Intl.message(
      'Clear all expenses',
      name: 'clearAllExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Last Months`
  String get lastMonths {
    return Intl.message('Last Months', name: 'lastMonths', desc: '', args: []);
  }

  /// `View past spending history`
  String get viewPastSpending {
    return Intl.message(
      'View past spending history',
      name: 'viewPastSpending',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Monthly Summary`
  String get monthlySummary {
    return Intl.message(
      'Monthly Summary',
      name: 'monthlySummary',
      desc: '',
      args: [],
    );
  }

  /// `No monthly summaries yet.\nAdd expenses to get started!`
  String get noSummariesYet {
    return Intl.message(
      'No monthly summaries yet.\nAdd expenses to get started!',
      name: 'noSummariesYet',
      desc: '',
      args: [],
    );
  }

  /// `Highest Spending`
  String get highestSpending {
    return Intl.message(
      'Highest Spending',
      name: 'highestSpending',
      desc: '',
      args: [],
    );
  }

  /// `Spending Breakdown`
  String get spendingBreakdown {
    return Intl.message(
      'Spending Breakdown',
      name: 'spendingBreakdown',
      desc: '',
      args: [],
    );
  }

  /// `Total Spent`
  String get totalSpent {
    return Intl.message('Total Spent', name: 'totalSpent', desc: '', args: []);
  }

  /// `of budget`
  String get ofBudget {
    return Intl.message('of budget', name: 'ofBudget', desc: '', args: []);
  }

  /// `Current Month`
  String get currentMonth {
    return Intl.message(
      'Current Month',
      name: 'currentMonth',
      desc: '',
      args: [],
    );
  }

  /// `Edit Transaction`
  String get editTransaction {
    return Intl.message(
      'Edit Transaction',
      name: 'editTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message('Note', name: 'note', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Category`
  String get categorySingular {
    return Intl.message(
      'Category',
      name: 'categorySingular',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 transaction} other{{count} transactions}}`
  String transactionsCount(num count) {
    return Intl.plural(
      count,
      one: '1 transaction',
      other: '$count transactions',
      name: 'transactionsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No route defined for {name}`
  String noRouteDefined(String name) {
    return Intl.message(
      'No route defined for $name',
      name: 'noRouteDefined',
      desc: '',
      args: [name],
    );
  }

  /// `No note`
  String get noNote {
    return Intl.message('No note', name: 'noNote', desc: '', args: []);
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Live`
  String get live {
    return Intl.message('Live', name: 'live', desc: '', args: []);
  }

  /// `Top`
  String get top {
    return Intl.message('Top', name: 'top', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `{count, plural, =1{1 category} other{{count} categories}}`
  String categoriesCount(num count) {
    return Intl.plural(
      count,
      one: '1 category',
      other: '$count categories',
      name: 'categoriesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Spending Chart`
  String get spendingChart {
    return Intl.message(
      'Spending Chart',
      name: 'spendingChart',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Months`
  String get months {
    return Intl.message('Months', name: 'months', desc: '', args: []);
  }

  /// `All-time Spent`
  String get allTimeSpent {
    return Intl.message(
      'All-time Spent',
      name: 'allTimeSpent',
      desc: '',
      args: [],
    );
  }

  /// `Avg / Month`
  String get avgPerMonth {
    return Intl.message('Avg / Month', name: 'avgPerMonth', desc: '', args: []);
  }

  /// `Add some note`
  String get noteHint {
    return Intl.message('Add some note', name: 'noteHint', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Add Task`
  String get addTask {
    return Intl.message('Add Task', name: 'addTask', desc: '', args: []);
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message('Edit Task', name: 'editTask', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Title is required`
  String get titleRequired {
    return Intl.message(
      'Title is required',
      name: 'titleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Priority`
  String get priority {
    return Intl.message('Priority', name: 'priority', desc: '', args: []);
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Medium`
  String get medium {
    return Intl.message('Medium', name: 'medium', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Mark as Completed`
  String get markAsCompleted {
    return Intl.message(
      'Mark as Completed',
      name: 'markAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Task Completed`
  String get taskCompleted {
    return Intl.message(
      'Task Completed',
      name: 'taskCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message('Delete Task', name: 'deleteTask', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `This Week`
  String get thisWeek {
    return Intl.message('This Week', name: 'thisWeek', desc: '', args: []);
  }

  /// `This Month`
  String get thisMonth {
    return Intl.message('This Month', name: 'thisMonth', desc: '', args: []);
  }

  /// `No tasks for this day`
  String get noTasks {
    return Intl.message(
      'No tasks for this day',
      name: 'noTasks',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Daily`
  String get daily {
    return Intl.message('Daily', name: 'daily', desc: '', args: []);
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
  }

  /// `Notifications for task reminders`
  String get rememberMeDescription {
    return Intl.message(
      'Notifications for task reminders',
      name: 'rememberMeDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
