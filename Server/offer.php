<?php

class OfferData {
  public $id;
  public $offerer;
  public $contractor;
  public $description;
  public $notes;
  public $deadline;
  public $deliveryWay;
  public $deliveryWayOption;
  public $price;
  public $score;

	static function initFromFileString($line) {
		$datas = explode(",", $line);
		if (count($datas) == 10) {
      $offerData = new OfferData();
      $offerData->id = $datas[0];
      $offerData->offerer = $datas[1];
			$offerData->contractor = $datas[2];
      $offerData->description = $datas[3];
      $offerData->notes = $datas[4];
      $offerData->deadline = $datas[5];
      $offerData->deliveryWay = $datas[6];
      $offerData->deliveryWayOption = $datas[7];
      $offerData->price = $datas[8];
      $offerData->score = $datas[9];
			return $offerData;
		}
		return null;
	}

  function toFileString() {
    $str = "";
    $str .= $this->id;
    $str .= ",";
    $str .= $this->offerer;
    $str .= ",";
    $str .= $this->contractor;
    $str .= ",";
    $str .= $this->description;
    $str .= ",";
    $str .= $this->notes;
    $str .= ",";
    $str .= $this->deadline;
    $str .= ",";
    $str .= $this->deliveryWay;
    $str .= ",";
    $str .= $this->deliveryWayOption;
    $str .= ",";
    $str .= $this->price;
    $str .= ",";
    $str .= $this->score;
    $str .= "\n";
    return $str;
  }
}

class Offer {

  const FILE_NAME = "data/offer.txt";
  const DELIVERABLES_DIRECTORY = "data/image/deliverables/";

	static function readAll() {
		if (file_exists(Offer::FILE_NAME)) {
			$fileData = file_get_contents(Offer::FILE_NAME);
			if ($fileData !== false) {
				$dataList = [];
				$lines = explode("\n", $fileData);
				for ($i = 0; $i < count($lines); $i++) {
					$data = OfferData::initFromFileString($lines[$i]);
					if (!is_null($data)) {
						$dataList[] = $data;
					}
				}
				return $dataList;
			}
		}
		return [];
	}

  static function create($offerer, $contractor, $description, $notes, $deadline, $deliveryWay, $deliveryWayOption) {

    $maxOfferId = -1;

    $offerList = Offer::readAll();

    echo(("<br>debug: " . count($offerList) . "<br>"));
    foreach ($offerList as $offerData) {
      $offerId = intval($offerData->id);
      if ($offerId > $maxOfferId) {
        $maxOfferId = $offerId;
      }
    }

    $nextOfferId = strval($maxOfferId + 1);

    date_default_timezone_set('Asia/Tokyo');

    $offerData = new OfferData();
    $offerData->id = $nextOfferId;
    $offerData->offerer = $offerer;
    $offerData->contractor = $contractor;
    $offerData->description = $description;
    $offerData->notes = $notes;
    $offerData->deadline = $deadline;
    $offerData->deliveryWay = $deliveryWay;
    $offerData->deliveryWayOption = $deliveryWayOption;
    $offerData->price = "";
    $offerData->score = "";

    return (file_put_contents(Offer::FILE_NAME, $offerData->toFileString(), FILE_APPEND) !== FALSE);
  }

  static function update($id, $price, $score) {

    $offerList = Offer::readAll();
    $find = false;

    date_default_timezone_set('Asia/Tokyo');

    foreach ($offerList as &$offerData) {
      if (strcmp($offerData->id, $id) == 0) {
        $newOfferData = new OfferData();
        $newOfferData->id = $id;
        $newOfferData->offerer = $offerData->offerer;
        $newOfferData->contractor = $offerData->contractor;
        $newOfferData->description = $offerData->description;
        $newOfferData->notes = $offerData->notes;
        $newOfferData->deadline = $offerData->deadline;
        $newOfferData->deliveryWay = $offerData->deliveryWay;
        $newOfferData->deliveryWayOption = $offerData->deliveryWayOption;
        $newOfferData->price = $price;
        $newOfferData->score = $score;
        $offerData = $newOfferData;

        $find = true;
        break;
      }
    }
    if (!$find) {
      return false;
    }

    $str = "";
    foreach($offerList as $data) {
      $str .= $data->toFileString();
    }
    return file_put_contents(Offer::FILE_NAME, $str) !== false;
  }

  static function uploadDeliverables($offerId, $file) {
    $fileName = Offer::DELIVERABLES_DIRECTORY . $offerId;
    return move_uploaded_file($file, $fileName);
  }
}

?>
