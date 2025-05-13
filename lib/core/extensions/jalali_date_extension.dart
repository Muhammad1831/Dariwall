extension JalaliDateExtension on String? {
  String? toJalaliDate() {
    if (this == null) return null;
    try {
      // Split the date and time parts
      final parts = this!.split('T');
      if (parts.length != 2) return null;
      
      // Parse date part (1404-01-22)
      final dateParts = parts[0].split('-');
      if (dateParts.length != 3) return null;
      
      // Parse time part (14:15)
      final timeParts = parts[1].split(':');
      if (timeParts.length != 2) return null;
      
      // Format the date and time
      final year = dateParts[0];
      final month = dateParts[1].padLeft(2, '0');
      final day = dateParts[2].padLeft(2, '0');
      final hour = timeParts[0].padLeft(2, '0');
      final minute = timeParts[1].padLeft(2, '0');
      
      return '$year/$month/$day $hour:$minute';
    } catch (e) {
      return null;
    }
  }

  String? toJalaliDateOnly() {
    if (this == null) return null;
    try {
      // Split the date and time parts
      final parts = this!.split('T');
      if (parts.length != 2) return null;
      
      // Parse date part (1404-01-22)
      final dateParts = parts[0].split('-');
      if (dateParts.length != 3) return null;
      
      // Format the date
      final year = dateParts[0];
      final month = dateParts[1].padLeft(2, '0');
      final day = dateParts[2].padLeft(2, '0');
      
      return '$year/$month/$day';
    } catch (e) {
      return null;
    }
  }

  String? toJalaliTimeOnly() {
    if (this == null) return null;
    try {
      // Split the date and time parts
      final parts = this!.split('T');
      if (parts.length != 2) return null;
      
      // Parse time part (14:15)
      final timeParts = parts[1].split(':');
      if (timeParts.length != 2) return null;
      
      // Format the time
      final hour = timeParts[0].padLeft(2, '0');
      final minute = timeParts[1].padLeft(2, '0');
      
      return '$hour:$minute';
    } catch (e) {
      return null;
    }
  }
} 
