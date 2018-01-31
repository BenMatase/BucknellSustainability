<?php
require_once 'google-api-php-client-2.2.1/vendor/autoload.php';

// Get $id_token via HTTPS POST.
$id_token = $_POST['idtoken'];

$CLIENT_ID = '438120227370-65o4j0kmk9mbij1bp3dqvnts9dh4kfrf.apps.googleusercontent.com';
$client = new Google_Client(['client_id' => $CLIENT_ID]);
$payload = $client->verifyIdToken($id_token);
if ($payload) {
  $userid = $payload['sub'];

	echo $userid;
} else {
  echo 'Invalid Id Token';
}
?>
