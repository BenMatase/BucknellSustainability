<?php
require_once 'vendor/autoload.php';

// Get $id_token via HTTPS POST.
$CLIENT_ID = '438120227370-lb3gicq14kf8nl6gh6d0rgtnqassqoej.apps.googleusercontent.com';
$client = new Google_Client(['client_id' => $CLIENT_ID]);  // Specify the CLIENT_ID of the app that accesses the backend
$payload = $client->verifyIdToken($id_token);
if ($payload) {
  $userid = $payload['sub'];
  // If request specified a G Suite domain:
  //$domain = $payload['hd'];
  echo 'validated'
} else {
  // Invalid ID token
  echo 'invalidated'
}

$config = json_decode(file_get_contents(__DIR__ . '/../../../config.json'));
$link = mysqli_connect($config->DB_URL, $config->DB_USERNAME, $config->DB_PASSWORD, $config->DB_NAME);

//make sure connection is established
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$table = $_GET['table'];
$condition = $_GET['condition'];
$fields = $_GET['fields'];

//get name, description, longitude, latitude, link from site table
$query = "SELECT $fields FROM $table $condition;";

//put al sites in an array and output as json
if ($result = mysqli_query($link, $query)) {
    $rows = Array();
    while ($row = mysqli_fetch_assoc($result)) {
        $rows[] = $row;
    }
    echo json_encode($rows);
    mysqli_free_result($result);
}

mysqli_close($link);
?>
