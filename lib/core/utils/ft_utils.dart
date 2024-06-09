const bool isLogEnabled = true;

showLog(message) {
  try {
    if (isLogEnabled) {
      print("FT: " + message);
    }
  } catch (e) {
    print(e);
  }
}
