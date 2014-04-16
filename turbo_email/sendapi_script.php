<?php

require_once "lib/TurboApiClient.php";

$url="http://www.picanada.org/game/index.php?authkey=".$authkey;
$content="<html><head><meta charset='UTF-8'></head><body>Please click <a href='".$url."'>link</a> to verify.</body></html>";

$email = new Email();
$email->setToList($tolist);
$email->setFrom("shawncc.huang@gmail.com");
$email->setSubject("TurboApiClient subject");
$email->setContent("TurboApiClient content");
$email->setHtmlContent($content);
$email->addCustomHeader('X-FirstHeader', "k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDT3MWLni6so1q9eQggRYBCLHFjohZkCnYHH8gZNDBm6zRrodRVpWpJQW7x3cWWiuBhS1X0IfBB80l5tqFa+yc+mVgnk8tkUzOHFbPQPp4fi7egTpMtsQW/ZMrxw73SItNvPr72qvJTYZNPxarMx+ULjEWybcfEdXHPY8jslGcpCwIDAQAB");
$email->addCustomHeader('X-SecondHeader', "k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDT3MWLni6so1q9eQggRYBCLHFjohZkCnYHH8gZNDBm6zRrodRVpWpJQW7x3cWWiuBhS1X0IfBB80l5tqFa+yc+mVgnk8tkUzOHFbPQPp4fi7egTpMtsQW/ZMrxw73SItNvPr72qvJTYZNPxarMx+ULjEWybcfEdXHPY8jslGcpCwIDAQAB");
//$email->addCustomHeader('X-Header-da-rimuovere', '');
//$email->removeCustomHeader('X-Header-da-rimuovere');


$turboApiClient = new TurboApiClient("shawncc.huang@gmail.com", "1USyPV6e");


$response = $turboApiClient->sendEmail($email);

var_dump($response);


