<?php

require "user.php";
require "offer.php";
require "chat.php";

$command = $_POST["command"];

if (strcmp($command, "createUser") == 0) {
  createUser();
} else if (strcmp($command, "updateUser") == 0) {
  updateUser();
} else if (strcmp($command, "updateUserImage") == 0) {
  updateUserImage();
} else if (strcmp($command, "getUser") == 0) {
  getUser();
} else if (strcmp($command, "createOffer") == 0) {
  createOffer();
} else if (strcmp($command, "updateOffer") == 0) {
  updateOffer();
} else if (strcmp($command, "uploadDeliverables") == 0) {
  uploadDeliverables();
} else if (strcmp($command, "getOffer") == 0) {
  getOffer();
} else if (strcmp($command, "getChat") == 0) {
  getChat();
} else if (strcmp($command, "postChat") == 0) {
  postChat();
}

else {
  createUser();
  updateUser();
  updateUserImage();
  getUser();
  createOffer();
  updateOffer();
  uploadDeliverables();
  getOffer();
  getChat();
  postChat();
  echo("unknown");
}

function createUser() {

  $email = $_POST["email"];
  $nickname = $_POST["nickname"];
  $area = $_POST["area"];
  $message = $_POST["message"];

  $userId = User::create($email, $nickname, $area, $message);
  if (is_null($userId)) {
    echo(json_encode(Array("result" => "1")));
  } else {
    echo(json_encode(Array("result" => "0", "userId" => $userId)));
  }
}

function updateUser() {

  $id = $_POST["id"];
  $nickname = $_POST["nickname"];
  $area = $_POST["aera"];
  $message = $_POST["message"];
  $price = $_POST["price"];
  $expenses = $_POST["expenses"];
  $prMovie = $_POST["prMovie"];
  $bank = $_POST["bank"];

  if (User::update($id, $nickname, $area, $message, $price, $expenses, $prMovie, $bank)) {
    echo(json_encode(Array("result" => "0")));
  } else {
    echo(json_encode(Array("result" => "1")));
  }
}

function updateUserImage() {

  $userId = $_POST["userId"];
  $file = $_FILES['image']['tmp_name'];
  if (User::uploadImage($userId, $file)) {
    echo(json_encode(Array("result" => "0")));
  } else {
    echo(json_encode(Array("result" => "1")));
  }
}

function getUser() {

  $users = [];
  $userList = User::readAll();

  foreach ($userList as $userData) {
    $users[] = Array("id" => $userData->id,
                      "nickname" => $userData->nickname,
                      "area" => $userData->area,
                      "message" => $userData->message,
                      "price" => $userData->price,
                      "expenses" => $userData->expenses,
                      "prMovie" => $userData->prMovie,
                      "bank" => $userData->bank);
  }
  $ret = Array("result" => "0", "users" => $users);
  echo(json_encode($ret));
}

function createOffer() {

  $offerer = $_POST["offerer"];
  $contractor = $_POST["contractor"];
  $description = $_POST["description"];
  $notes = $_POST["notes"];
  $deadline = $_POST["deadline"];
  $deliveryWay = $_POST["deliveryWay"];
  $deliveryWayOption = $_POST["deliveryWayOption"];

  if (Offer::create($offerer, $contractor, $description, $notes, $deadline, $deliveryWay, $deliveryWayOption)) {
    echo(json_encode(Array("result" => "0")));
  } else {
    echo(json_encode(Array("result" => "1")));
  }
}

function updateOffer() {

  $id = $_POST["id"];
  $price = $_POST["price"];
  $score = $_POST["score"];

  if (Offer::update($id, $price, $score)) {
    echo(json_encode(Array("result" => "0")));
  } else {
    echo(json_encode(Array("result" => "1")));
  }
}

function uploadDeliverables() {

  $offerId = $_POST["offerId"];
  $file = $_FILES['file']['tmp_name'];
  if (Offer::uploadDeliverables($offerId, $file)) {
    echo(json_encode(Array("result" => "0")));
  } else {
    echo(json_encode(Array("result" => "1")));
  }
}

function getOffer() {

  $offers = [];
  $offerList = Offer::readAll();

  foreach ($offerList as $offerData) {
    $offers[] = Array("id" => $offerData->id,
                      "offerer" => $offerData->offerer,
                      "contractor" => $offerData->contractor,
                      "description" => $offerData->description,
                      "notes" => $offerData->notes,
                      "deadline" => $offerData->deadline,
                      "deliveryWay" => $offerData->deliveryWay,
                      "deliveryWayOption" => $offerData->deliveryWayOption,
                      "price" => $offerData->price,
                      "score" => $offerData->score);
  }
  $ret = Array("result" => "0", "offers" => $offers);
  echo(json_encode($ret));
}

function getChat() {

  $userId = $_POST["userId"];
  $chats = [];

  foreach(Chat::read($userId) as $data) {
    $chats[] = Array("id" => $data->id,
            "sender" => $data->sender,
            "receiver" => $data->receiver,
            "offerId" => $data->offerId,
            "chat" => $data->chat,
            "datetime" => $data->datetime);
  }
  $ret = Array("result" => "0", "chats" => $chats);
  echo(json_encode($ret));
}

function postChat() {

  $id = $_POST["id"];
  $sender = $_POST["sender"];
  $receiver = $_POST["receiver"];
  $offerId = $_POST["offerId"];
  $chat = $_POST["chat"];

  Chat::create($id, $sender, $receiver, $offerId, $chat);
  echo(json_encode(Array("result" => "0")));
}

function DebugSave($str){

	date_default_timezone_set('Asia/Tokyo');

	$d = date('Y-m-d H:i:s');
	$s = $d . " " . $str . "\r\n";
	file_put_contents("debug.txt", $s, FILE_APPEND);
}

?>
