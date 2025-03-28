// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:healthmini/utils/general_imports.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  final String contactIcon = 'assets/svg/contact_icon.svg';

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _sendForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseFirestore.instance.collection('contact_form').add({
          'name': _nameController.text,
          'email': _emailController.text,
          'question': _questionController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        setState(() {
          _nameController.clear();
          _emailController.clear();
          _questionController.clear();
        });
        _showSuccessDialog();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const SuccessDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us',
            style: AppTextStyles.mediumTextStyles(fontSize: 22)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout();
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              contactIcon,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildContactForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          SvgPicture.asset(
            contactIcon,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          _buildContactForm(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(
            contactIcon,
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          _buildContactForm(),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Us',
            style: AppTextStyles.semiBoldTextStyles(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'We\'d love to hear from you! Please fill out the form below to get in touch with us.',
            style: AppTextStyles.mediumTextStyles(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              labelText: 'Question',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your question';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: _sendForm,
            child: Container(
              alignment: Alignment.center,
              height: 55,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  color: AppColors.appColors,
                  borderRadius: BorderRadius.circular(10)),
              child: isLoading
                  ? LoadingAnimationWidget.horizontalRotatingDots(
                      color: AppColors.whiteColor,
                      size: 35,
                    )
                  : Text(
                      'Send',
                      style: AppTextStyles.semiBoldTextStyles(
                          fontSize: 16, textColor: AppColors.whiteColor),
                    ),
            ),
          ),
          const SizedBox(height: 40),
          _buildContactInfoSection(),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop/Tablet Layout
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactInfoItem(
                icon: Icons.location_on,
                label: 'Address',
                content: '302 Suman Swarg, Surat, Gujrat, 394105',
              ),
              _buildContactInfoItem(
                icon: Icons.phone,
                label: 'Phone',
                content: '+91 9328003180',
              ),
              _buildContactInfoItem(
                icon: Icons.email,
                label: 'Email',
                content: 'viragvadhel7@gmail.com',
              ),
            ],
          );
        } else {
          // Mobile Layout
          return Column(
            children: [
              _buildContactInfoItem(
                icon: Icons.location_on,
                label: 'Address',
                content: '302 Suman Swarg, Surat, Gujrat, 394105',
              ),
              const SizedBox(height: 20),
              _buildContactInfoItem(
                icon: Icons.phone,
                label: 'Phone',
                content: '+91 9328003180',
              ),
              const SizedBox(height: 20),
              _buildContactInfoItem(
                icon: Icons.email,
                label: 'Email',
                content: 'viragvadhel7@gmail.com',
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String label,
    required String content,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.appColors, size: 30),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.semiBoldTextStyles(fontSize: 16),
            ),
            Text(
              content,
              style: AppTextStyles.mediumTextStyles(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
