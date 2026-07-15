import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/generated/l10n.dart';

class AmountHederWidget extends StatelessWidget {
  const AmountHederWidget({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 67, 136, 146),
            Color.fromARGB(255, 49, 67, 86),
            Color(0xFF2C3E50),
            Color.fromARGB(255, 39, 55, 70),
            Color.fromARGB(255, 67, 96, 126),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // Dont forget to add this leaner gradient
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18).r,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16).r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).amount, style: AppStrings.font18white700Weight),
                Gap(10.h),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 28,
                    ),

                    hintStyle: AppStrings.font18white700Weight.copyWith(
                      color: Colors.white70,
                      fontSize: 22.sp,
                    ),
                    hintText: "0.00",
                    contentPadding: EdgeInsets.all(18).r,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
