<?php
// --- EXPORT TO CSV LOGIC ---
// If the URL has ?export=true, generate a CSV file instead of standard JSON
if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['export']) && $_GET['export'] == 'true') {
    $host = 'localhost'; $user = 'root'; $pass = ''; $dbname = 'micro_components';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
    // Set headers to force download of a CSV file
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="micro_orders_export.csv"');
    
    // Open output stream
    $output = fopen('php://output', 'w');
    
    // Write CSV Column Headers
    fputcsv($output, ['Order ID', 'Part Number', 'Description', 'Quantity', 'Status', 'Date Created']);
    
    // Fetch data and write rows
    $sql = "SELECT * FROM orders ORDER BY created_at DESC";
    $result = $conn->query($sql);
    if ($result && $result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            fputcsv($output, $row);
        }
    }
    
    fclose($output);
    $conn->close();
    exit(); // Stop execution so JSON headers below aren't sent
}

// --- STANDARD API LOGIC ---
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') { exit(0); }

$host = 'localhost';
$user = 'root';
$pass = ''; 
$dbname = 'micro_components';

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'GET') {
    $sql = "SELECT * FROM orders ORDER BY created_at DESC";
    $result = $conn->query($sql);
    $orders = [];
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) { $orders[] = $row; }
    }
    echo json_encode($orders);
} 
elseif ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $part = $conn->real_escape_string($data['part_number']);
    $desc = $conn->real_escape_string($data['description']);
    $qty = (int)$data['quantity'];

    $sql = "INSERT INTO orders (part_number, description, quantity) VALUES ('$part', '$desc', $qty)";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Order placed successfully", "id" => $conn->insert_id]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}
elseif ($method == 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = (int)$data['order_id'];
    $status = $conn->real_escape_string($data['status']);

    $sql = "UPDATE orders SET status = '$status' WHERE order_id = $id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Status updated"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}
elseif ($method == 'DELETE') {
    // Process delete requests
    $data = json_decode(file_get_contents("php://input"), true);
    $id = (int)$data['order_id'];

    $sql = "DELETE FROM orders WHERE order_id = $id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Order deleted"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>