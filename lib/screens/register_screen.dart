import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/firebase_service.dart';
import 'home_after_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form state
  final TextEditingController _motherNameController = TextEditingController();
  String _selectedCareStage = 'pregnancy'; // 'pregnancy' or 'postpartum'
  String _selectedLanguage = 'hindi'; // 'hindi' or 'english'
  
  // Conditional fields based on care stage
  int? _pregnancyMonth; // 1-9
  int? _babyAgeWeeks; // 1-52
  String _deliveryType = 'normal'; // 'normal' or 'csection'

  // Emergency Contacts
  final TextEditingController _primaryContactNameController = TextEditingController();
  final TextEditingController _primaryContactPhoneController = TextEditingController();
  final TextEditingController _secondaryContactNameController = TextEditingController();
  final TextEditingController _secondaryContactPhoneController = TextEditingController();
  final TextEditingController _tertiaryContactNameController = TextEditingController();
  final TextEditingController _tertiaryContactPhoneController = TextEditingController();

  @override
  void dispose() {
    _motherNameController.dispose();
    _primaryContactNameController.dispose();
    _primaryContactPhoneController.dispose();
    _secondaryContactNameController.dispose();
    _secondaryContactPhoneController.dispose();
    _tertiaryContactNameController.dispose();
    _tertiaryContactPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5F0), // Warm beige background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD4845A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              _buildWelcomeHeader(),
              const SizedBox(height: 32),

              // Step 1: Mother's Name
              _buildStep1MotherName(),
              const SizedBox(height: 28),

              // Step 2: Care Stage Selection
              _buildStep2CareStage(),
              const SizedBox(height: 28),

              // Step 3: Conditional Input Section Placeholder
              _buildStep3ConditionalSection(),
              const SizedBox(height: 28),

              // Step 4: Language Preference
              _buildStep4LanguagePreference(),
              const SizedBox(height: 28),

              // Step 5: Emergency Contacts
              _buildStep5EmergencyContacts(),
              const SizedBox(height: 40),

              // Continue Button
              _buildContinueButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Digital Dadi',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFB8653B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Let\'s get you started with personalized care guidance',
          style: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStep1MotherName() {
    return Card(
      elevation: 3,
      shadowColor: const Color(0xFFD4845A).withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber('1', 'Mother\'s Name'),
            const SizedBox(height: 14),
            TextField(
              controller: _motherNameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4845A),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2CareStage() {
    return Card(
      elevation: 3,
      shadowColor: const Color(0xFFD4845A).withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber('2', 'What stage are you at?'),
            const SizedBox(height: 14),
            _buildRadioOption(
              value: 'pregnancy',
              label: 'Pregnancy',
              groupValue: _selectedCareStage,
              onChanged: (value) {
                setState(() {
                  _selectedCareStage = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildRadioOption(
              value: 'postpartum',
              label: 'Postpartum',
              groupValue: _selectedCareStage,
              onChanged: (value) {
                setState(() {
                  _selectedCareStage = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption({
    required String value,
    required String label,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: groupValue == value ? const Color(0xFFD4845A) : Colors.grey[300]!,
          width: groupValue == value ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: groupValue == value
            ? const Color(0xFFFCE7D9)
            : Colors.transparent,
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        activeColor: const Color(0xFFD4845A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildStep3ConditionalSection() {
    return Card(
      elevation: 3,
      shadowColor: const Color(0xFFD4845A).withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber('3', 'Additional Information'),
            const SizedBox(height: 14),
            _selectedCareStage == 'pregnancy'
                ? _buildPregnancySection()
                : _buildPostpartumSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPregnancySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which month of pregnancy are you in?',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: _pregnancyMonth,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Select pregnancy month (1-9)',
                style: GoogleFonts.nunito(fontSize: 15),
              ),
            ),
            isExpanded: true,
            underline: const SizedBox(),
            items: List.generate(9, (index) {
              int month = index + 1;
              return DropdownMenuItem<int>(
                value: month,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Month $month',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                ),
              );
            }),
            onChanged: (value) {
              setState(() {
                _pregnancyMonth = value;
              });
            },
          ),
        ),
        if (_pregnancyMonth != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE7D9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFD4845A),
                width: 1,
              ),
            ),
            child: Text(
              'You\'re in Month $_pregnancyMonth of your pregnancy journey. We\'ll provide personalized care tips for this stage.',
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: const Color(0xFF333333),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPostpartumSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How many weeks old is your baby?',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: _babyAgeWeeks,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Select baby\'s age in weeks (1-52)',
                style: GoogleFonts.nunito(fontSize: 15),
              ),
            ),
            isExpanded: true,
            underline: const SizedBox(),
            items: List.generate(52, (index) {
              int weeks = index + 1;
              return DropdownMenuItem<int>(
                value: weeks,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Week $weeks',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                ),
              );
            }),
            onChanged: (value) {
              setState(() {
                _babyAgeWeeks = value;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'How was your delivery?',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        _buildDeliveryTypeOption(
          value: 'normal',
          label: 'Normal Delivery',
          groupValue: _deliveryType,
          onChanged: (value) {
            setState(() {
              _deliveryType = value!;
            });
          },
        ),
        const SizedBox(height: 12),
        _buildDeliveryTypeOption(
          value: 'csection',
          label: 'C-Section',
          groupValue: _deliveryType,
          onChanged: (value) {
            setState(() {
              _deliveryType = value!;
            });
          },
        ),
        if (_babyAgeWeeks != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE7D9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFD4845A),
                width: 1,
              ),
            ),
            child: Text(
              'Your baby is $_babyAgeWeeks week${_babyAgeWeeks == 1 ? '' : 's'} old. We\'ll provide post-delivery guidance tailored to your recovery stage and delivery type.',
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: const Color(0xFF333333),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDeliveryTypeOption({
    required String value,
    required String label,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: groupValue == value ? const Color(0xFFD4845A) : Colors.grey[300]!,
          width: groupValue == value ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: groupValue == value
            ? const Color(0xFFFCE7D9)
            : Colors.transparent,
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        activeColor: const Color(0xFFD4845A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildStep4LanguagePreference() {
    return Card(
      elevation: 3,
      shadowColor: const Color(0xFFD4845A).withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber('4', 'Language Preference'),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _buildLanguageButton(
                    label: 'हिंदी',
                    value: 'hindi',
                    isSelected: _selectedLanguage == 'hindi',
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'hindi';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildLanguageButton(
                    label: 'English',
                    value: 'english',
                    isSelected: _selectedLanguage == 'english',
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'english';
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String label,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFD4845A) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? const Color(0xFFFCE7D9)
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isSelected
                  ? const Color(0xFFD4845A)
                  : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepNumber(String number, String title) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFD4845A),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD4845A).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: 16,
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildStep5EmergencyContacts() {
    return Card(
      elevation: 3,
      shadowColor: const Color(0xFFD4845A).withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber('5', 'Emergency Contacts'),
            const SizedBox(height: 12),
            Text(
              'Please provide emergency contacts in priority order. We\'ll reach out to them in case of urgent situations.',
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            
            // Primary Emergency Contact
            _buildEmergencyContactCard(
              priority: 'Primary',
              priorityIcon: Icons.priority_high,
              nameController: _primaryContactNameController,
              phoneController: _primaryContactPhoneController,
              index: 0,
            ),
            const SizedBox(height: 14),
            
            // Secondary Emergency Contact
            _buildEmergencyContactCard(
              priority: 'Secondary',
              priorityIcon: Icons.priority_high_outlined,
              nameController: _secondaryContactNameController,
              phoneController: _secondaryContactPhoneController,
              index: 1,
            ),
            const SizedBox(height: 14),
            
            // Tertiary Emergency Contact
            _buildEmergencyContactCard(
              priority: 'Tertiary',
              priorityIcon: Icons.info_outline,
              nameController: _tertiaryContactNameController,
              phoneController: _tertiaryContactPhoneController,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactCard({
    required String priority,
    required IconData priorityIcon,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required int index,
  }) {
    final List<Color> priorityColors = [
      const Color(0xFFD4845A), // Primary - warm rose
      const Color(0xFFC2754A), // Secondary - darker rose
      const Color(0xFFB8653B), // Tertiary - soft brown
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100]!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority Header
          Row(
            children: [
              Icon(
                priorityIcon,
                size: 18,
                color: priorityColors[index],
              ),
              const SizedBox(width: 8),
              Text(
                '$priority Contact',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: priorityColors[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Name Field
          Text(
            'Contact Name',
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter name',
              prefixIcon: const Icon(Icons.person_outline, size: 20),
              prefixIconColor: Colors.grey[500],
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: priorityColors[index],
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Phone Field
          Text(
            'Phone Number',
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '10-digit number',
              prefixIcon: const Icon(Icons.phone_outlined, size: 20),
              prefixIconColor: Colors.grey[500],
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: priorityColors[index],
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Validate required fields
          if (_motherNameController.text.isEmpty) {
            _showErrorDialog('Please enter your name');
            return;
          }

          if (_primaryContactNameController.text.isEmpty ||
              _primaryContactPhoneController.text.isEmpty) {
            _showErrorDialog(
                'Please provide at least primary emergency contact');
            return;
          }

          // Show loading dialog
          _showLoadingDialog();

          try {
            // Prepare emergency contacts data
            Map<String, Map<String, String>> emergencyContacts = {
              'primary': {
                'name': _primaryContactNameController.text,
                'phone': _primaryContactPhoneController.text,
              },
              'secondary': {
                'name': _secondaryContactNameController.text,
                'phone': _secondaryContactPhoneController.text,
              },
              'tertiary': {
                'name': _tertiaryContactNameController.text,
                'phone': _tertiaryContactPhoneController.text,
              },
            };

            // Get current user
            var currentUser = FirebaseService.getCurrentUser();

            if (currentUser != null) {
              // Save user registration data to Firestore
              await FirebaseService.saveUserRegistrationData(
                userId: currentUser.uid,
                motherName: _motherNameController.text,
                careStage: _selectedCareStage,
                pregnancyMonth: _pregnancyMonth,
                babyAgeWeeks: _babyAgeWeeks,
                deliveryType: _deliveryType,
                languagePreference: _selectedLanguage,
                emergencyContacts: emergencyContacts,
              );

              // Close loading dialog
              if (mounted) {
                Navigator.of(context).pop();
              }

              // Show success message
              _showSuccessDialog('Registration successful!');

              // Navigate to HomeAfterLoginScreen
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeAfterLoginScreen()),
                );
              }
            } else {
              // Close loading dialog
              if (mounted) {
                Navigator.of(context).pop();
              }
              _showErrorDialog('User not authenticated. Please sign up first.');
            }
          } catch (e) {
            // Close loading dialog
            if (mounted) {
              Navigator.of(context).pop();
            }
            _showErrorDialog('Error: ${e.toString()}');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4845A),
          disabledBackgroundColor: Colors.grey[400],
          disabledForegroundColor: Colors.grey[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
          shadowColor: const Color(0xFFD4845A).withOpacity(0.3),
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // Helper method to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Error',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: Colors.red[700],
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: const Color(0xFF333333),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  color: Colors.red[700],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method to show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Success',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: Colors.green[700],
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: const Color(0xFF333333),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method to show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: Color(0xFFD4845A),
                ),
                const SizedBox(height: 16),
                Text(
                  'Saving your information...',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
