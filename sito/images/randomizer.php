<?php
// Abilita CORS
header("Access-Control-Allow-Origin: *");

try {
    $pdo = new PDO("mysql:host=localhost;dbname=my_stefanoburro", "my_stefanoburro", "yE3ZFq2U2ckR");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Errore di connessione: " . $e->getMessage();
    exit;
}

// Ricezione ruolo scelto
$ruolo = $_GET['ruolo'] ?? 'attacco';

// 1. Operatore random
$stmt = $pdo->prepare("SELECT * FROM OPERATORI WHERE ruolo = :ruolo ORDER BY RAND() LIMIT 1");
$stmt->execute(['ruolo' => $ruolo]);
$operatore = $stmt->fetch();

if (!$operatore) {
    echo "<p>Nessun operatore trovato per il ruolo: $ruolo</p>";
    exit;
}

echo "<h2>Operatore: {$operatore['nome']}</h2>";
echo "<p>Abilità: {$operatore['abilita']}</p>";
echo "<p>Velocità: {$operatore['velocita']} | Armatura: {$operatore['armatura']} | Difficoltà: {$operatore['difficolta']}</p>";

// 2. Armi associate
$stmt = $pdo->prepare("
    SELECT * FROM ARMI 
    WHERE idarma IN (
        SELECT idarma FROM OPERATORE_ARMA WHERE idoperatore = :idop
    )
    ORDER BY RAND()
");
$stmt->execute(['idop' => $operatore['idoperatore']]);
$armi = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 3. Una per categoria
$scelte_armi = [];
$selezionate = [];

foreach ($armi as $arma) {
    $cat = strtolower($arma['categoria']);
    if (!isset($selezionate[$cat])) {
        $scelte_armi[] = $arma;
        $selezionate[$cat] = true;
    }
}

// 4. Attachment casuali
foreach ($scelte_armi as $arma) {
    echo "<h3>Arma ({$arma['categoria']}): {$arma['nome']}</h3>";
    echo "<p>Tipologia: {$arma['tipologia']} | Caricatore: {$arma['caricatore']} | Danni: {$arma['danni']}</p>";
    echo "<p>{$arma['descrizione']}</p>";

    $stmt = $pdo->prepare("
        SELECT A.* FROM ATTACHMENTS A
        JOIN ARMA_ATTACHMENT AA ON A.idattachment = AA.idattachment
        WHERE AA.idarma = :idarma
        ORDER BY RAND()
    ");
    $stmt->execute(['idarma' => $arma['idarma']]);
    $attachments = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $cat_usate = [];

    foreach ($attachments as $a) {
        $categoria = strtolower($a['categoria']);
        if (!isset($cat_usate[$categoria])) {
            echo "<p><strong>Attachment ($categoria):</strong> {$a['nome']} - {$a['descrizione']}</p>";
            $cat_usate[$categoria] = true;
        }
    }
}

// 5. Utility
$stmt = $pdo->prepare("
    SELECT U.* FROM UTILITIES U
    JOIN OPERATORE_UTILITY OU ON U.idutility = OU.idutility
    WHERE OU.idoperatore = :idop
    ORDER BY RAND()
    LIMIT 1
");
$stmt->execute(['idop' => $operatore['idoperatore']]);
$utility = $stmt->fetch();

if ($utility) {
    echo "<h3>Utility: {$utility['nome']}</h3>";
    echo "<p>{$utility['descrizione']} (x{$utility['numero']})</p>";
} else {
    echo "<p>Nessuna utility trovata per questo operatore.</p>";
}
?>