<?php

require_once dirname(__FILE__,2)."/library/base.inc.php";

$xml = Utils::getXML("/var/log/nmap-fastscan.xml");

foreach ($xml->host as $host) {
  $state = strval($host->status->attributes()->state);
  $reason = strval($host->status->attributes()->reason);
  if ($state === "up" && $reason === "echo-reply") {
    $ip = strval($host->address->attributes()->addr);
    if ($host->hostnames->hostname->attributes() !== null) {
      $hostname = strval($host->hostnames->hostname->attributes()->name);
    } else {
      $hostname = $ip;
    }
    echo $ip." - ".$hostname."\n";
  }
}

$json = Utils::getJSON("/var/log/fritzbox-smarthome.json");
foreach ($json["device"] as $device) {
  $name = $device["name"];
  $identifier = str_replace(" ","", $device["identifier"]);
  $functionbitname = $device["functionbitname"];
  $present = $device["present"] == "1";
  if (in_array("Temperatursensor", $functionbitname)) {
    $temperature = $device["temperature"]["celsius"];
  } else {
    $temperature = false;
  }
  if (in_array("Energie Messgerät", $functionbitname)) {
    $power = $device["powermeter"]["power"];
  } else {
    $power = false;
  }
  if (in_array("Schaltsteckdose", $functionbitname)) {
    $switchable = true;
    $state = $device["switch"]["state"];
  } else {
    $switchable = false;
    $state = false;
  }
  
  echo $present." - ".$name." - ".$identifier." - (".$temperature."/10)C - ".$power."mW - ".$state."\n";
}


$csv = Utils::getCSV("/var/log/fritzbox-anrufliste.csv");
$log = Utils::getLog("/var/log/fritzbox-getip.log");
$log = Utils::getLog("/var/log/fritzbox-traffic.log");
