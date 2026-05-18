import 'package:flutter/material.dart';
import '../../constants.dart';

class LocationSelector extends StatefulWidget {
  final String selectedLocation;
  final Function(String) onLocationChanged;

  const LocationSelector({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final List<String> locations = [
    'Dhaka', 'Chittagong', 'Rajshahi', 'Khulna',
    'Sylhet', 'Barishal', 'Rangpur', 'Mymensingh',
    'Comilla', 'Narayanganj', 'Gazipur', 'Jessore'
  ];

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppConstants.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your City',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose your city to see movies near you',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: locations.map((location) {
                  return FilterChip(
                    label: Text(location),
                    selected: widget.selectedLocation == location,
                    onSelected: (selected) {
                      if (selected) {
                        widget.onLocationChanged(location);
                        Navigator.pop(context);
                      }
                    },
                    selectedColor: AppConstants.primaryColor,
                    backgroundColor: Colors.grey[800],
                    labelStyle: TextStyle(
                      color: widget.selectedLocation == location
                          ? Colors.white
                          : Colors.grey[300],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Movies near you • ${widget.selectedLocation}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: _showLocationBottomSheet,
            child: const Text(
              'Change',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}