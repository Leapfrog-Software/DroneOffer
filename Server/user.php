<?php

class UserData {
  public $id;
  public $email;
  public $nickname;
  public $area;
  public $message;
  public $price;
  public $expenses;
  public $prMovie;
  public $bank;

	static function initFromFileString($line) {
		$datas = explode(",", $line);
		if (count($datas) == 9) {
      $userData = new UserData();
      $userData->id = $datas[0];
      $userData->email = $datas[1];
			$userData->nickname = $datas[2];
      $userData->area = $datas[3];
      $userData->message = $datas[4];
      $userData->price = $datas[5];
      $userData->expenses = $datas[6];
      $userData->prMovie = $datas[7];
      $userData->bank = $datas[8];
			return $userData;
		}
		return null;
	}

  function toFileString() {
    $str = "";
    $str .= $this->id;
    $str .= ",";
    $str .= $this->email;
    $str .= ",";
    $str .= $this->nickname;
    $str .= ",";
    $str .= $this->area;
    $str .= ",";
    $str .= $this->message;
    $str .= ",";
    $str .= $this->price;
    $str .= ",";
    $str .= $this->expenses;
    $str .= ",";
    $str .= $this->prMovie;
    $str .= ",";
    $str .= $this->bank;
    $str .= "\n";
    return $str;
  }
}

class User {

  const FILE_NAME = "data/user.txt";
  const IMAGE_DIRECTORY = "data/image/user/";

	static function readAll() {
		if (file_exists(User::FILE_NAME)) {
			$fileData = file_get_contents(User::FILE_NAME);
			if ($fileData !== false) {
				$dataList = [];
				$lines = explode("\n", $fileData);
				for ($i = 0; $i < count($lines); $i++) {
					$data = UserData::initFromFileString($lines[$i]);
					if (!is_null($data)) {
						$dataList[] = $data;
					}
				}
				return $dataList;
			}
		}
		return [];
	}

  static function create($email, $nickname, $area, $message) {

    $maxUserId = -1;

    $userList = User::readAll();
    foreach ($userList as $userData) {
      $userId = intval($userData->id);
      if ($userId > $maxUserId) {
        $maxUserId = $userId;
      }
    }

    $nextUserId = strval($maxUserId + 1);

    date_default_timezone_set('Asia/Tokyo');

    $userData = new UserData();
    $userData->id = $nextUserId;
    $userData->email = $email;
    $userData->nickname = $nickname;
    $userData->area = $area;
    $userData->message = $message;
    $userData->price = "";
    $userData->expenses = "";
    $userData->prMovie = "";
    $userData->bank = "";

    if (file_put_contents(User::FILE_NAME, $userData->toFileString(), FILE_APPEND) !== FALSE) {
      return $userData->id;
    } else {
      return null;
    }
  }

  static function update($id, $nickname, $area, $message, $price, $expenses, $prMovie, $bank) {

    $userList = User::readAll();
    $find = false;

    date_default_timezone_set('Asia/Tokyo');

    foreach ($userList as &$userData) {
      if (strcmp($userData->id, $id) == 0) {
        $newUserData = new UserData();
        $newUserData->id = $id;
        $newUserData->email = $userData->email;
        $newUserData->nickname = $nickname;
        $newUserData->area = $area;
        $newUserData->message = $message;
        $newUserData->price = $price;
        $newUserData->expenses = $expenses;
        $newUserData->prMovie = $prMovie;
        $newUserData->bank = $bank;
        $userData = $newUserData;

        $find = true;
        break;
      }
    }
    if (!$find) {
      return false;
    }

    $str = "";
    foreach($userList as $data) {
      $str .= $data->toFileString();
    }
    return file_put_contents(User::FILE_NAME, $str) !== false;
  }

  static function uploadImage($userId, $file) {
    $fileName = User::IMAGE_DIRECTORY . $userId;
    return move_uploaded_file($file, $fileName);
  }
}

?>
