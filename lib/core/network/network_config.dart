//Switch Environment

//Live url here
String liveUrl =
    'https://ua-mobile-health-server-emmanuelochem.vercel.app:5001/api/v1/';

//Staging base url here

class NetworkConfig {
  static const bool isLive = false;
  static const String localUrl = 'http://192.168.43.177:5001';
  static const String liveUrl =
      'https://ua-mobile-health-server-emmanuelochem.vercel.app';
  static const String basePath = '/api/v1/';

  static const String baseUrl =
      isLive ? liveUrl + basePath : localUrl + basePath;
}
