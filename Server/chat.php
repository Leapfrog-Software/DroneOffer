<?php

class ChatData {
  
  public $id;
  public $sender;
  public $receiver;
  public $chat;
  public $datetime;

  static function initFromFileString($line) {

    if (strlen($line) == 0) {
      return null;
    }

    $datas = explode(",", $line);
    if (count($datas) >= 5) {
      $chatData = new ChatData();
      $chatData->id = $datas[0];
      $chatData->sender = $datas[1];
      $chatData->receiver = $datas[2];
      $chatData->chat = $datas[3];
      $chatData->datetime = $datas[4];
      return $chatData;
    }
    return null;
  }

  function toFileString() {
    return $this->id . ","
        . $this->sender . ","
        . $this->receiver . ","
        . $this->chat . ","
        . $this->datetime . "\n";
  }
}

class Chat {

  const DIRECTORY_NAME = "../data/chat/";

  static function listUpFile($userId) {

      $fileNames = [];
      foreach(glob(Chat::DIRECTORY_NAME . "*", GLOB_BRACE) as $file){
        if (is_file($file)) {
            $removed1 = str_replace(".txt", "", $file);
            $removed2 = str_replace(Chat::DIRECTORY_NAME, "", $removed1);
            $userIds = explode("-", $removed2);
            if (count($userIds) == 2) {
                if ((strcmp($userIds[0], $userId) == 0) || (strcmp($userIds[1], $userId) == 0)) {
                  $fileNames[] = $file;
                }
            }
          }
      }
      return $fileNames;
    }

  static function readFile($fileName) {

      if (file_exists($fileName)) {
          $fileData = file_get_contents($fileName);
          if ($fileData !== false) {
            $chatList = [];
            $lines = explode("\n", $fileData);
            for ($i = 0; $i < count($lines); $i++) {
                $chatData = ChatData::initFromFileString($lines[$i]);
                if (!is_null($chatData)) {
                  $chatList[] = $chatData;
                }
            }
            return $chatList;
          }
      }
      return [];
    }

  static function read($userId) {

    $chats = [];
    $files = Chat::listUpFile($userId);
    foreach($files as $file) {
      $chats += Chat::readFile($file);
    }
    return $chats;
  }

  static function create($id, $sender, $receiver, $chat) {

    $data = new ChatData();
    $data->id = $id;
    $data->sender = $sender;
    $data->receiver = $receiver;
    $data->chat = $chat;

    date_default_timezone_set("Asia/Tokyo");
    $data->datetime = date("YmdHis");

    $fileName1 = Chat::DIRECTORY_NAME . $sender . "-" . $receiver . ".txt";
    $fileName2 = Chat::DIRECTORY_NAME . $receiver . "-" . $sender . ".txt";
    $fileName = "";
    if (file_exists($fileName1)) {
      $fileName = $fileName1;
    } else {
      $fileName = $fileName2;
    }
    file_put_contents($fileName, $data->toFileString(), FILE_APPEND);
  }
}

?>
