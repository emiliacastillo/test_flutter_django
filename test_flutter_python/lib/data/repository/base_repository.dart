import 'dart:io';

class BaseRepository {
  bool isHostUnableException(dynamic ex) => ex is SocketException;
}
