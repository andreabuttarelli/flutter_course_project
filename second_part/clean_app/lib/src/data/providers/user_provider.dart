class UserProvider {
  const UserProvider();

  Future<String> getUserID() async {
    await Future.delayed(const Duration(seconds: 1));
    return '1';
  }
}
