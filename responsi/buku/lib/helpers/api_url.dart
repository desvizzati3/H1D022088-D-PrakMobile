class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api/buku';

  static const String registrasi =
      'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  static const String listStatus = baseUrl + '/status'; // Mengambil list status
  static const String createStatus =
      baseUrl + '/status' + 'create'; // Membuat status baru

  static String updateStatus(int id) {
    return baseUrl +
        '/status/' +
        id.toString() +
        'update'; // Update status berdasarkan ID
  }

  static String showStatus(int id) {
    return baseUrl +
        '/status/' +
        id.toString(); // Tampilkan detail status berdasarkan ID
  }

  static String deleteStatus(int id) {
    return baseUrl +
        '/status/' +
        id.toString() +
        '/delete'; // Hapus status berdasarkan ID
  }
}
