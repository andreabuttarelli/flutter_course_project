class UserProviderOffline {
  const UserProviderOffline();

  Future<String> getUserID() async {
    await Future.delayed(const Duration(seconds: 1));
    return '1';
  }
}
