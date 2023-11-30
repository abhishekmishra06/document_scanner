import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_lib;

double _getThresholdFromPixels(Uint8List pixels) {
  // Calculate the average pixel value.
  int averagePixelValue = 0;
  for (int i = 0; i < pixels.length; i++) {
    averagePixelValue += pixels[i];
  }
  averagePixelValue ~/= pixels.length;

  // Calculate the standard deviation of the pixel values.
  double standardDeviation = 0.0;
  for (int i = 0; i < pixels.length; i++) {
    standardDeviation += pow(pixels[i] - averagePixelValue, 2).toDouble();
  }
  standardDeviation = sqrt(standardDeviation / pixels.length);

  // Calculate the threshold.
  double threshold = averagePixelValue - standardDeviation;

  // Return the threshold.

  return threshold.abs();
}

Uint8List convertToBlackAndWhite(Uint8List imagePixels) {
  var grayImage = image_lib.decodeImage(imagePixels)!;
  grayImage = image_lib.grayscale(grayImage);
  return image_lib.encodePng(grayImage);
}

Uint8List enhanceImageSharpness(Uint8List imagePixels) {
  var image = image_lib.decodeImage(imagePixels)!;
  // image = image_lib.adjustColor(image, brightness: .5);
  image = image_lib.contrast(image, contrast: 110);
  return image_lib.encodePng(image);
}
