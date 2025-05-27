class AppUtils {
  /// Obscures 4 digits out of a phone number.
  ///
  /// Example usage: `AppUtils.obscurePhoneNumber(08034443333)`
  ///
  /// Expected output: `08034****33`
  static String obscurePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 7) {
      throw ArgumentError("Invalid phone number length");
    }

    // Extracting the last two, hiding the next four, and keeping the rest visible
    String lastTwoDigits = phoneNumber.substring(phoneNumber.length - 2);
    String hiddenDigits = '****';
    String visibleDigits = phoneNumber.substring(0, phoneNumber.length - 6);

    // Creating the formatted string
    String formattedPhoneNumber = "$visibleDigits$hiddenDigits$lastTwoDigits";

    return formattedPhoneNumber;
  }

/// Formats a time input in seconds to its equivalent in minutes
/// and seconds.
/// 
/// Example usage: ``AppUtils.formatSeconds(100) 
/// 
/// Expected output: 1:40
  static String formatSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

}
