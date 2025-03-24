import 'package:healthmini/utils/general_imports.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appName = 'HealthMini';
  final String appLogo = 'assets/images/logo.png';
  final bool isHide; // New parameter to hide profile

  const ResponsiveAppBar({super.key, this.isHide = false});

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
          //BuyNowButton(onPressed: (){}),
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
          //BuyNowButton(onPressed: (){}),
          PopupMenuButton<String>(
            onSelected: (value) {
              _handleMenuSelection(context, value);
            },
            itemBuilder: (context) {
              return _buildPopupMenuItems(context);
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
        //BuyNowButton(onPressed: (){}),
        PopupMenuButton<String>(
          onSelected: (value) {
            _handleMenuSelection(context, value);
          },
          itemBuilder: (context) {
            return _buildPopupMenuItems(context);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Row(
      children: [
        _buildTextButton(context, 'About Us', 'about'),
        _buildTextButton(context, 'Contact Us', 'contact'),
        _buildTextButton(context, 'Reviews', 'reviews'),
        _buildTextButton(context, 'Privacy Policy', 'privacy'),
        _buildTextButton(context, 'Terms & Conditions', 'terms'),
        _buildTextButton(context, 'Refund Policy', 'refund'),
        if (!isHide) // Hide Update Profile if isHide is true
          _buildTextButton(context, 'Update Profile', 'profile'),
      ],
    );
  }

  List<PopupMenuItem<String>> _buildPopupMenuItems(BuildContext context) {
    List<PopupMenuItem<String>> items = [
      _buildPopupMenuItem('About Us', 'about'),
      _buildPopupMenuItem('Contact Us', 'contact'),
      _buildPopupMenuItem('Reviews', 'reviews'),
      _buildPopupMenuItem('Privacy Policy', 'privacy'),
      _buildPopupMenuItem('Terms & Conditions', 'terms'),
      _buildPopupMenuItem('Refund Policy', 'refund'),
    ];

    if (!isHide) {
      items.add(_buildPopupMenuItem('Update Profile', 'profile'));
    }
    return items;
  }

  Widget _buildTextButton(BuildContext context, String title, String value) {
    return TextButton(
      onPressed: () => _handleMenuSelection(context, value),
      child: Text(
        title,
        style: AppTextStyles.mediumTextStyles(fontSize: 14),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        title,
        style: AppTextStyles.mediumTextStyles(fontSize: 14),
      ),
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
      case 'profile':
        Navigator.pushNamed(context, '/user_location');
        break;
      case 'refund':
        Navigator.pushNamed(context, '/refund_policy');
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BuyNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const BuyNowButton(
      {super.key, required this.onPressed, this.text = 'Buy Now'});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust button size based on screen width
    double buttonWidth = screenWidth > 1024
        ? 100
        : screenWidth > 650
            ? 100
            : 100;

    double buttonHeight = screenWidth > 1024 ? 35 : 35;

    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appColors),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth > 1024 ? 14 : 14,
              fontWeight: FontWeight.bold,
              color: AppColors.appColors,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
