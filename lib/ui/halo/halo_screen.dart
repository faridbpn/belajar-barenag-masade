import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteSubmissionScreen extends StatefulWidget {
  const QuoteSubmissionScreen({super.key});

  @override
  State<QuoteSubmissionScreen> createState() => _QuoteSubmissionScreenState();
}

class _QuoteSubmissionScreenState extends State<QuoteSubmissionScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedCategory;
  String? _selectedMood;

  Future<void> _submitQuote() async {
    if (_nameController.text.isEmpty || _quoteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and Quote are required!")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('quotes').add({
        'name': _nameController.text,
        'quote': _quoteController.text,
        'category': _selectedCategory ?? "Unknown",
        'mood': _selectedMood ?? "Unknown",
        'author': _authorController.text,
        'source': _sourceController.text,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Quote submitted successfully!")),
      );

      _nameController.clear();
      _quoteController.clear();
      _authorController.clear();
      _sourceController.clear();
      _messageController.clear();
      setState(() {
        _selectedCategory = null;
        _selectedMood = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit quote: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Put Some Quote"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.format_quote, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Please Fill out the Form!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Your Name", _nameController),
              _buildTextField("Quote", _quoteController, maxLines: 3),
              _buildDropdown("Quote Category", ["Motivation", "Humor", "Life", "Love"], (value) {
                setState(() {
                  _selectedCategory = value;
                });
              }),
              _buildDropdown("Mood When Writing", ["Happy", "Sad", "Inspired", "Anxious"], (value) {
                setState(() {
                  _selectedMood = value;
                });
              }),
              _buildTextField("Author (Optional)", _authorController),
              _buildTextField("Inspiration Source", _sourceController),
              _buildTextField("Additional Message", _messageController, maxLines: 2),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _submitQuote,
                child: const Text(
                  "Submit Quote",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: options
            .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}