<?php

require_once "pest/Pest.php";

class TurboClient extends Pest{

    protected $user;
    protected $pass;

    public function __construct($base_url, $user="", $pass=""){
        $this->user=$user;
        $this->pass=$pass;
        Pest::__construct($base_url);
     }

    public function post($url, $data, $headers=array()) {
        return parent::post($url, $data, $headers);
    }

    public function put($url, $data, $headers=array()) {
        return parent::put($url, $data, $headers);
    }

    protected function prepRequest($opts, $url) {
        $opts[CURLOPT_HTTPHEADER][] = 'Accept: application/json';
        $opts[CURLOPT_HTTPHEADER][] = 'Content-Language: application/json';
        $opts[CURLOPT_HTTPHEADER][] = 'Authuser: '.$this->user;
        $opts[CURLOPT_HTTPHEADER][] = 'Authpass: '.$this->pass;
        return parent::prepRequest($opts, $url);
    }

    public function processBody($body) {
        return json_decode($body, true);
    }


}