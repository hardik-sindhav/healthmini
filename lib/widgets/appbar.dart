import 'package:flutter/material.dart';
import 'package:healthmini/const/colors.dart';
import 'package:healthmini/utils/textstyles.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appName = 'HealthMini';
  final String appLogo = 'assets/images/logo.png';
  const ResponsiveAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return _buildDesktopAppBar(context);
        } else if (constraints.maxWidth > 600) {
          return _buildTabletAppBar(context);
        } else {
          return _buildMobileAppBar(context);
        }
      },
    );
  }

  PreferredSizeWidget _buildDesktopAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(appLogo, height: 40),
          const SizedBox(width: 10),
          Text(
            "Health",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.appColors,
              fontSize: 30,
            ),
          ),
          Text(
            "mini",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.blackColor,
              fontSize: 30,
            ),
          ),
          const Spacer(),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildTabletAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(appLogo, height: 30),
          const SizedBox(width: 10),
          Text(
            "Health",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.appColors,
              fontSize: 25,
            ),
          ),
          Text(
            "mini",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.blackColor,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
            onSelected: (value) {
              _handleMenuSelection(context, value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 'about',
                    child: Text(
                      'About Us',
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                    )),
                PopupMenuItem(
                    value: 'contact',
                    child: Text(
                      'Contact Us',
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                    )),
                PopupMenuItem(
                    value: 'reviews',
                    child: Text(
                      'Reviews',
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                    )),
                PopupMenuItem(
                    value: 'privacy',
                    child: Text(
                      'Privacy Policy',
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                    )),
                PopupMenuItem(
                    value: 'terms',
                    child: Text(
                      'Terms & Conditions',
                      style: AppTextStyles.mediumTextStyles(fontSize: 14),
                    )),
              ];
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(appLogo, height: 30),
          const SizedBox(width: 10),
          Text(
            "Health",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.appColors,
              fontSize: 20,
            ),
          ),
          Text(
            "mini",
            style: AppTextStyles.semiBoldTextStyles(
              textColor: AppColors.blackColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            _handleMenuSelection(context, value);
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: 'about',
                  child: Text(
                    'About Us',
                    style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  )),
              PopupMenuItem(
                  value: 'contact',
                  child: Text(
                    'Contact Us',
                    style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  )),
              PopupMenuItem(
                  value: 'reviews',
                  child: Text(
                    'Reviews',
                    style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  )),
              PopupMenuItem(
                  value: 'privacy',
                  child: Text(
                    'Privacy Policy',
                    style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  )),
              PopupMenuItem(
                  value: 'terms',
                  child: Text(
                    'Terms & Conditions',
                    style: AppTextStyles.mediumTextStyles(fontSize: 14),
                  )),
            ];
          },
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () => _handleMenuSelection(context, 'about'),
            child: Text(
              'About Us',
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            )),
        TextButton(
            onPressed: () => _handleMenuSelection(context, 'contact'),
            child: Text(
              'Contact Us',
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            )),
        TextButton(
            onPressed: () => _handleMenuSelection(context, 'reviews'),
            child: Text(
              'Reviews',
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            )),
        TextButton(
            onPressed: () => _handleMenuSelection(context, 'privacy'),
            child: Text(
              'Privacy Policy',
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            )),
        TextButton(
            onPressed: () => _handleMenuSelection(context, 'terms'),
            child: Text(
              'Terms & Conditions',
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            )),
      ],
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'about':
        Navigator.pushNamed(context, '/about');
        break;
      case 'contact':
        Navigator.pushNamed(context, '/contact_page');
        break;
      case 'reviews':
        Navigator.pushNamed(context, '/reviews');
        break;
      case 'privacy':
        Navigator.pushNamed(context, '/privacy_policy');
        break;
      case 'terms':
        Navigator.pushNamed(context, '/terms_conditions');
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
