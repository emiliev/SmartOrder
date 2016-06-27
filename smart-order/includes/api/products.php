<?php 

require_once '../db.php';

function get_all() {
	global $connection;
	$sql = "SELECT * FROM products";
	$query = $connection->prepare($sql);
	$query->execute();
	$productsData = array();
	
	while($row=$query->fetch(PDO::FETCH_ASSOC)){
		$productsData['products'][] = $row;
	}
	
	echo json_encode($productsData);
}

if ($_SERVER["REQUEST_METHOD"] == "GET" && !isset($_GET["id"])) {
	get_all();
}
 
?>