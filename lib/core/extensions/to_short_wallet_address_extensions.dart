extension StringExtension on String {
  String toShortWalletAddress() {
    if (length <= 8) return this;
    return '${substring(0, 4)}...${substring(length - 4)}';
  }
} 
