<?php

$username = "sikelianos";
$token = "aac9eee6defd8d18121a85a17fece3c6feb7aa69";
$page = "1054295";

function curl_request($url, $request_body) {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $request_body);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-POST_DATA_FORMAT: xml'));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	$response = curl_exec($ch);	
	curl_close($ch);
	return $response;
}

$url = "http://".$username.".backpackit.com/ws/page/".$page;
$request_body = "<request>\r\n<token>".$token."</token>\r\n</request>";
$result = curl_request($url, $request_body);
print_r($result);

?>