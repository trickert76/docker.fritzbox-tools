<?php

abstract class Utils {
  public static function getXML(string $file) :SimpleXMLElement {
    try {
      return simplexml_load_file($file);
    } catch (Throwable $throwable) {
      Log::error("Could not read XML file ".$file,$throwable);
      return new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8"?>');
    }
  }
  
  public static function getJSON(string $file) :array {
    try {
      $body = file_get_contents($file);
      return json_decode($body,true);
    } catch (Throwable $throwable) {
      Log::error("Could not read JSON file ".$file,$throwable);
      return array();
    }
  }
}