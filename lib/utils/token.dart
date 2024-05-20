import 'dart:convert';

import 'package:crypto/crypto.dart';

String token(String nroAparelho, String version){
  var bytes = utf8.encode("PCP-VERSAO_$version-$nroAparelho");
  var digest = md5.convert(bytes);
  return digest.toString().toUpperCase();
}