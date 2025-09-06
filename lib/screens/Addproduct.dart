import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'place_order.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final List<Uint8List?> _images = List.filled(4, null);
  final List<TextEditingController> _controllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  String? _errorMessage;

  Future<void> _pickImage(int index) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true, // ensures bytes are available
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        Uint8List? imageBytes = file.bytes;

        // If bytes are null, load from file path
        if (imageBytes == null && file.path != null) {
          imageBytes = await File(file.path!).readAsBytes();
        }

        if (imageBytes != null) {
          setState(() {
            _images[index] = imageBytes;
          });
        }
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to pick image: $e");
    }
  }

  Widget _buildImageBox(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        height: MediaQuery.of(context).size.width / 2 - 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: _images[index] == null
            ? const Center(child: Icon(Icons.add_a_photo, size: 30))
            : ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            _images[index]!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, int controllerIndex,
      {TextInputType inputType = TextInputType.text, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: _controllers[controllerIndex],
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon ?? Icons.text_fields),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  bool _validateForm() {
    final allFieldsFilled = _controllers.every((c) => c.text.isNotEmpty) &&
        _images.every((img) => img != null);
    if (!allFieldsFilled) {
      setState(() => _errorMessage = "Please fill all fields and upload images");
    }
    return allFieldsFilled;
  }

  void _submitProduct() {
    if (_validateForm()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlaceOrder(
            imageList: _images.whereType<Uint8List>().toList(),
            name: _controllers[0].text,
            description: _controllers[1].text,
            price: _controllers[2].text,
            manufacturing: _controllers[3].text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildImageBox(0)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildImageBox(1)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildImageBox(2)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildImageBox(3)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField('Name Of Product', 0, icon: Icons.label),
            _buildInputField('Product Description', 1, icon: Icons.description),
            _buildInputField('Amount In Rupee', 2,
                inputType: TextInputType.number, icon: Icons.currency_rupee),
            _buildInputField('Manufacturing Details', 3, icon: Icons.factory),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ElevatedButton(
              onPressed: _submitProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child:
              const Text("Submit", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
