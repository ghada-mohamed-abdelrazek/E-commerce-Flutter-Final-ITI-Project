import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_final_project/core/resources/app_color.dart';
import 'package:iti_final_project/core/resources/app_images.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/user/user_cubit.dart';

import '../../../core/resources/log_out.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserCubit()
        ..getUser(3),

      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserFailure) {
            return Center(child: Text(state.message));
          }

          if (state is UserSuccess) {
            final user = state.user;
            final first = user.name?.firstname ?? "User";
            final last = user.name?.lastname ?? "";
            final fullName = "$first $last".trim();

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.primaryGray,
                      radius: 30,
                      child:ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                  child: Image.network("https://i.imgur.com/LDOO4Qs.jpg"))
                    ),
                    Text(fullName,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.profile),
                          SizedBox(width: 12),
                          Text("Profile",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.setting),
                          SizedBox(width: 12),
                          Text("Setting",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.contact),
                          SizedBox(width: 12),
                          Text("Contact",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.share),
                          SizedBox(width: 12),
                          Text("Share App",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8
                      ),
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.help),
                          SizedBox(width: 12),
                          Text("Help",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                    ),
                    GestureDetector(
                      onTap: () {
                        LogOutSheet.show(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sign Out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffF55F1F),
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
