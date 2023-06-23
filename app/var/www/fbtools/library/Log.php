<?php

abstract class Log {
  public static function error(string $message, Throwable $throwable = null) :void {
    echo "[error]: ".$message;
    if ($throwable !== null) {
      echo " ".$throwable->getMessage();
      echo " ".$throwable->getTraceAsString();
    }
    echo "\n";
  }
}