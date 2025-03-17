import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AudioHelper {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final box = GetStorage(); 
  static RxDouble volume = 1.0.obs; 

  
  static void loadVolume() {
    volume.value =
        box.read('volume') ??
        1.0; 
    _audioPlayer.setVolume(volume.value);
  }

  
  static Future<void> playSound(String soundPath) async {
    await _audioPlayer.setSourceAsset(soundPath);
    await _audioPlayer.setVolume(volume.value);
    await _audioPlayer.resume();
  }

  
  static void setVolume(double newVolume) {
    volume.value = newVolume;
    _audioPlayer.setVolume(volume.value);
    box.write('volume', volume.value); 
  }

    // =================================== root ==================================

  static const String _root = "sounds";

  // ================================== images =================================

  static const String keyboard = "$_root/keyboard.wav";
  static const String delete = "$_root/delete.wav";
  static const String enter = "$_root/enter.wav";
  static const String gift = "$_root/gift.wav";
}
