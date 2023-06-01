//Switch Environment

//Live url here
String liveUrl =
    'http://ec2-44-201-178-180.compute-1.amazonaws.com:5001/api/v1/';

//Staging base url here

class NetworkConfig {
  static const bool isLive = true;
  static const String localUrl = 'http://192.168.43.177:5001/api/v1/';
  static const String liveUrl =
      'http://ec2-44-201-178-180.compute-1.amazonaws.com:5001';
  static const String basePath = '/api/v1/';

  static const String baseUrl =
      isLive ? liveUrl + basePath : localUrl + basePath;
}
