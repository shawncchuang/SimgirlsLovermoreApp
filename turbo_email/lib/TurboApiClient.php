<?php

require_once  "TurboClient.php";
require_once  "Email.php";

class TurboApiClient{
	
	protected $username;
	protected $password;
	private $serverUrl = "https://api.turbo-smtp.com/api";
	
	public function __construct($username, $password) {
       $this->username = $username;
	   $this->password = $password;
   }
	
	protected function authorize(){
		try {
			$api = new TurboClient($this->serverUrl, $this->username, $this->password);
			return $api;
		} catch (Pest_Forbidden $ex) {
		    return null;		    
		}
	}
	
	public function sendEmail($email){
		$api = $this->authorize();
		if($api){
			try {
			    	$response = $api->post(
			    		'/mail/send',
			       		$email->getPostParameters() 
			    	);
			    return $response;
			} catch (Pest_NotFound $e) {
			    return $e;
			}
		}else{
			return "Authorization error";
		}
	}
};