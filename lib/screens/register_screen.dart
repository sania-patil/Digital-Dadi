import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form state
  final TextEditingController _motherNameController = TextEditingController();
  String _selectedCareStage = 'pregnancy'; // 'pregnancy' or 'postpartum'
  String _selectedLanguage = 'English'; // 'hindi' or 'English'

  @override
  void dispose() {
    _motherNameController.dispose();
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
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFFB8653B),
                fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Let\'s get you started with personalized care guidance',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStep1MotherName() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!,
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!,
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
        borderRadius: BorderRadius.circular(8),
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        activeColor: const Color(0xFFD4845A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildStep3ConditionalSection() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Center(
                child: Text(
                  'Content will appear based on\nyour care stage selection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4LanguagePreference() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!,
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
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? const Color(0xFFFCE7D9)
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFD4845A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF333333),
                fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null, // Disabled for now
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4845A),
          disabledBackgroundColor: Colors.grey[400],
          disabledForegroundColor: Colors.grey[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
