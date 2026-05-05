# Test Script - Gym Products Microservice API
# Configuración
$BASE_URL = "http://localhost:8080/api/v1/products"
$HEADERS = @{ "Content-Type" = "application/json" }
$COLOR_SUCCESS = "Green"
$COLOR_ERROR = "Red"
$COLOR_WARNING = "Yellow"
$COLOR_INFO = "Cyan"

# Contadores
$testCount = 0
$passCount = 0
$failCount = 0
$productIds = @()

function Print-Header {
    param([string]$message)
    Write-Host ""
    Write-Host "========================================" -ForegroundColor $COLOR_INFO
    Write-Host $message -ForegroundColor $COLOR_INFO
    Write-Host "========================================" -ForegroundColor $COLOR_INFO
    Write-Host ""
}

function Print-TestResult {
    param([string]$testName, [bool]$passed, [string]$details = "")
    $script:testCount++

    if ($passed) {
        $script:passCount++
        Write-Host "[OK] $testName" -ForegroundColor $COLOR_SUCCESS
    } else {
        $script:failCount++
        Write-Host "[FAIL] $testName" -ForegroundColor $COLOR_ERROR
    }

    if ($details) {
        Write-Host "     $details" -ForegroundColor $COLOR_WARNING
    }
}

function Test-ConnectionStatus {
    Print-Header "Verificando Conexion con el Servidor..."

    try {
        $response = Invoke-WebRequest -Uri $BASE_URL -Method Get -Headers $HEADERS -UseBasicParsing -ErrorAction Stop
        Print-TestResult "Servidor disponible en $BASE_URL" $true
        return $true
    } catch {
        Print-TestResult "Servidor disponible en $BASE_URL" $false "Error: $($_.Exception.Message)"
        return $false
    }
}

function Test-CreateProduct {
    param([string]$name, [string]$brand, [string]$category, [decimal]$price, [int]$quantity)

    $body = @{
        name = $name
        brand = $brand
        category = $category
        price = $price
        stockQuantity = $quantity
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri $BASE_URL -Method Post -Headers $HEADERS -Body $body
        $script:productIds += $response.id
        Print-TestResult "Crear producto: $name" $true "ID: $($response.id)"
        return $response.id
    } catch {
        Print-TestResult "Crear producto: $name" $false $($_.ErrorDetails.Message)
        return $null
    }
}

function Test-GetAllProducts {
    param([int]$page = 0, [int]$size = 10)

    $queryString = "?page=$page" + "&size=$size"
    $url = $BASE_URL + $queryString

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $HEADERS
        $count = $response.content.Count
        Print-TestResult "Listar productos (page=$page, size=$size)" $true "Total: $($response.totalElements), En pagina: $count"
        return $response
    } catch {
        Print-TestResult "Listar productos" $false $($_.ErrorDetails.Message)
        return $null
    }
}

function Test-GetProductById {
    param([string]$id)

    $url = "$BASE_URL/$id"

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $HEADERS
        Print-TestResult "Obtener producto por ID" $true "Nombre: $($response.name)"
        return $response
    } catch {
        Print-TestResult "Obtener producto por ID: $id" $false "No encontrado"
        return $null
    }
}

function Test-UpdateProduct {
    param([string]$id, [string]$name, [string]$brand, [string]$category, [decimal]$price, [int]$quantity)

    $url = "$BASE_URL/$id"
    $body = @{
        name = $name
        brand = $brand
        category = $category
        price = $price
        stockQuantity = $quantity
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri $url -Method Put -Headers $HEADERS -Body $body
        Print-TestResult "Actualizar producto (PUT)" $true "ID: $id"
        return $response
    } catch {
        Print-TestResult "Actualizar producto (PUT)" $false $($_.ErrorDetails.Message)
        return $null
    }
}

function Test-PatchProduct {
    param([string]$id, [decimal]$price = $null, [int]$quantity = $null)

    $url = "$BASE_URL/$id"
    $patchObj = @{}

    if ($price -ne $null) { $patchObj.price = $price }
    if ($quantity -ne $null) { $patchObj.stockQuantity = $quantity }

    $body = $patchObj | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri $url -Method Patch -Headers $HEADERS -Body $body
        Print-TestResult "Actualizar producto (PATCH)" $true "ID: $id"
        return $response
    } catch {
        Print-TestResult "Actualizar producto (PATCH)" $false $($_.ErrorDetails.Message)
        return $null
    }
}

function Test-DeleteProduct {
    param([string]$id)

    $url = "$BASE_URL/$id"

    try {
        Invoke-RestMethod -Uri $url -Method Delete -Headers $HEADERS
        Print-TestResult "Eliminar producto" $true "ID: $id"
        return $true
    } catch {
        Print-TestResult "Eliminar producto" $false $($_.ErrorDetails.Message)
        return $false
    }
}

function Test-NotFoundError {
    param([string]$fakeId = "550e8400-e29b-41d4-a716-000000000000")

    $url = "$BASE_URL/$fakeId"

    try {
        Invoke-RestMethod -Uri $url -Method Get -Headers $HEADERS -ErrorAction Stop
        Print-TestResult "Error 404 - Producto no encontrado" $false "No lanzo excepcion"
    } catch {
        if ($_.Exception.Response.StatusCode -eq 404) {
            Print-TestResult "Error 404 - Producto no encontrado" $true
        } else {
            Print-TestResult "Error 404 - Producto no encontrado" $false "Status: $($_.Exception.Response.StatusCode)"
        }
    }
}

function Test-ValidationErrors {
    Print-Header "Probando Validaciones..."

    # Test: Crear sin nombre
    $body = @{
        name = ""
        price = 29.99
        stockQuantity = 50
    } | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $BASE_URL -Method Post -Headers $HEADERS -Body $body -ErrorAction Stop
        Print-TestResult "Validación: Nombre requerido" $false "No lanzó excepción"
    } catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Print-TestResult "Validación: Nombre requerido" $true
        } else {
            Print-TestResult "Validación: Nombre requerido" $false
        }
    }

    # Test: Crear sin precio
    $body = @{
        name = "Test Product"
        price = $null
        stockQuantity = 50
    } | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $BASE_URL -Method Post -Headers $HEADERS -Body $body -ErrorAction Stop
        Print-TestResult "Validación: Precio requerido" $false "No lanzó excepción"
    } catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Print-TestResult "Validación: Precio requerido" $true
        } else {
            Print-TestResult "Validación: Precio requerido" $false
        }
    }
}

# EJECUCION PRINCIPAL

Print-Header "PRUEBAS DEL MICROSERVICIO GYM PRODUCTS"

# Verificar conexión
if (-not (Test-ConnectionStatus)) {
    exit 1
}

# Test de Lectura (GET)
Print-Header "Test 1: Obtener Productos (GET)"
$products = Test-GetAllProducts

# Test de Creación (POST)
Print-Header "Test 2: Crear Productos (POST)"
$id1 = Test-CreateProduct "Whey Protein Gold" "Gold Standard" "Supplements" 49.99 100
$id2 = Test-CreateProduct "Dumbbell Set" "CAP" "Equipment" 89.99 50
$id3 = Test-CreateProduct "Yoga Mat" "Lululemon" "Apparel" 88.00 75

# Listar de nuevo
Print-Header "Test 3: Verificar Productos Creados"
Test-GetAllProducts

# Test de Lectura por ID (GET /{id})
Print-Header "Test 4: Obtener Producto por ID"
if ($id1) {
    Test-GetProductById $id1
}

# Test de Actualización Completa (PUT)
Print-Header "Test 5: Actualizar Producto Completo (PUT)"
if ($id1) {
    Test-UpdateProduct $id1 "Whey Protein Premium" "Gold Standard Ultra" "Supplements" 59.99 150
}

# Test de Actualización Parcial (PATCH)
Print-Header "Test 6: Actualizar Parcialmente (PATCH)"
if ($id2) {
    Test-PatchProduct $id2 -price 79.99
}

if ($id3) {
    Test-PatchProduct $id3 -quantity 100
}

# Test de Errores 404
Print-Header "Test 7: Errores - Producto No Encontrado"
Test-NotFoundError

# Test de Eliminación (DELETE)
Print-Header "Test 8: Eliminar Producto (DELETE)"
if ($id1) {
    Test-DeleteProduct $id1
}

# Verificar eliminación
Print-Header "Test 9: Verificar Eliminacion"
if ($id1) {
    Test-NotFoundError $id1
}

# Listado final
Print-Header "Test 10: Estado Final de Productos"
Test-GetAllProducts

# Resumen
Print-Header "RESUMEN DE PRUEBAS"
Write-Host "Total de pruebas: $testCount" -ForegroundColor $COLOR_INFO
Write-Host "Pruebas exitosas: $passCount" -ForegroundColor $COLOR_SUCCESS
Write-Host "Pruebas fallidas: $failCount" -ForegroundColor $(if ($failCount -eq 0) { $COLOR_SUCCESS } else { $COLOR_ERROR })

$successRate = if ($testCount -gt 0) { [math]::Round(($passCount / $testCount) * 100, 2) } else { 0 }
Write-Host "Tasa de exito: $successRate%" -ForegroundColor $(if ($successRate -eq 100) { $COLOR_SUCCESS } else { $COLOR_WARNING })

if ($failCount -eq 0) {
    Write-Host "" -ForegroundColor $COLOR_SUCCESS
    Write-Host "EXITO: Todas las pruebas pasaron correctamente!" -ForegroundColor $COLOR_SUCCESS
} else {
    Write-Host "" -ForegroundColor $COLOR_ERROR
    Write-Host "ADVERTENCIA: Algunas pruebas fallaron." -ForegroundColor $COLOR_ERROR
}

Write-Host ""

