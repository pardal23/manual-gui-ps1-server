Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- CONFIGURAÇÃO DA JANELA PRINCIPAL ---
$F = New-Object System.Windows.Forms.Form
$F.Text = 'A Janela Louca V3 - Painel de Controlo & Bloco de Notas Avançado'
$F.Size = New-Object System.Drawing.Size(1020, 720)
$F.StartPosition = 'CenterScreen'
$F.BackColor = [System.Drawing.Color]::FromArgb(15,17,26)
$F.FormBorderStyle = 'FixedSingle'
$F.MaximizeBox = $false
$F.TopMost = $true 

# Fontes Globais
$FntTitulo = New-Object System.Drawing.Font('Segoe UI',10,[System.Drawing.FontStyle]::Bold)
$FntTexto = New-Object System.Drawing.Font('Courier New',9)
$FntLabel = New-Object System.Drawing.Font('Segoe UI',9)

# --- COLUNA ESQUERDA: ENTRADA DE DADOS & BASE64 ---
$L1 = New-Object System.Windows.Forms.Label
$L1.Text = '1. ESCREVE A TUA STRING / CÓDIGO POWERSHELL:'
$L1.Location = New-Object System.Drawing.Point(20, 15)
$L1.Size = New-Object System.Drawing.Size(450, 20)
$L1.ForeColor = [System.Drawing.Color]::Cyan
$L1.Font = $FntTitulo
$F.Controls.Add($L1)

$InputString = New-Object System.Windows.Forms.TextBox
$InputString.Multiline = $true
$InputString.Location = New-Object System.Drawing.Point(20, 40)
$InputString.Size = New-Object System.Drawing.Size(450, 120)
$InputString.Font = $FntTexto
$InputString.BackColor = [System.Drawing.Color]::FromArgb(30, 35, 50)
$InputString.ForeColor = [System.Drawing.Color]::White
$InputString.ScrollBars = 'Vertical'
$InputString.Text = "Get-Process | Select-Object -First 5"
$F.Controls.Add($InputString)

# Label Base64
$L_B64 = New-Object System.Windows.Forms.Label
$L_B64.Text = 'CÓDIGO TRADUZIDO EM BASE64 (PRONTO PARA -ENCODEDCOMMAND):'
$L_B64.Location = New-Object System.Drawing.Point(20, 175)
$L_B64.Size = New-Object System.Drawing.Size(450, 20)
$L_B64.ForeColor = [System.Drawing.Color]::Magenta
$L_B64.Font = $FntTitulo
$F.Controls.Add($L_B64)

$OutputBase64 = New-Object System.Windows.Forms.TextBox
$OutputBase64.Multiline = $true
$OutputBase64.Location = New-Object System.Drawing.Point(20, 200)
$OutputBase64.Size = New-Object System.Drawing.Size(450, 100)
$OutputBase64.Font = $FntTexto
$OutputBase64.BackColor = [System.Drawing.Color]::FromArgb(25, 25, 35)
$OutputBase64.ForeColor = [System.Drawing.Color]::Yellow
$OutputBase64.ReadOnly = $true
$OutputBase64.ScrollBars = 'Vertical'
$F.Controls.Add($OutputBase64)

# --- BOTÕES DE AÇÃO ---
$BtnExecutar = New-Object System.Windows.Forms.Button
$BtnExecutar.Text = '⚡ TRANSFORMAR STRING EM COMANDO REAL & EXECUTAR'
$BtnExecutar.Location = New-Object System.Drawing.Point(20, 315)
$BtnExecutar.Size = New-Object System.Drawing.Size(450, 40)
$BtnExecutar.BackColor = [System.Drawing.Color]::FromArgb(255, 0, 85)
$BtnExecutar.ForeColor = [System.Drawing.Color]::White
$BtnExecutar.FlatStyle = 'Flat'
$BtnExecutar.Font = $FntTitulo
$F.Controls.Add($BtnExecutar)

$BtnLink = New-Object System.Windows.Forms.Button
$BtnLink.Text = '📖 ABRIR TUTORIAL DE COMANDOS BASE64 (ADSECURITY)'
$BtnLink.Location = New-Object System.Drawing.Point(20, 365)
$BtnLink.Size = New-Object System.Drawing.Size(450, 30)
$BtnLink.BackColor = [System.Drawing.Color]::FromArgb(40, 45, 65)
$BtnLink.ForeColor = [System.Drawing.Color]::Cyan
$BtnLink.FlatStyle = 'Flat'
$BtnLink.Font = $FntLabel
$F.Controls.Add($BtnLink)


# --- COLUNA DIREITA SUPERIOR: BANCO DE COMANDOS SEGUROS ---
$L2 = New-Object System.Windows.Forms.Label
$L2.Text = '2. BANCO DE COMANDOS CLICÁVEIS (DUPLO CLIQUE PARA CARREGAR):'
$L2.Location = New-Object System.Drawing.Point(500, 15)
$L2.Size = New-Object System.Drawing.Size(480, 20)
$L2.ForeColor = [System.Drawing.Color]::Yellow
$L2.Font = $FntTitulo
$F.Controls.Add($L2)

$ListBoxCmds = New-Object System.Windows.Forms.ListBox
$ListBoxCmds.Location = New-Object System.Drawing.Point(500, 40)
$ListBoxCmds.Size = New-Object System.Drawing.Size(480, 180)
$ListBoxCmds.BackColor = [System.Drawing.Color]::FromArgb(20, 25, 40)
$ListBoxCmds.ForeColor = [System.Drawing.Color]::White
$ListBoxCmds.Font = $FntLabel
$F.Controls.Add($ListBoxCmds)

# Lista estável de comandos clicáveis
$ComandosPoderosos = @(
    "Test-NetConnection -ComputerName 8.8.8.8 -Port 53"
    "Resolve-DnsName -Name google.com -Type MX"
    "Get-NetIPAddress | Format-Table IPAddress, InterfaceAlias"
    "Get-NetTCPConnection -State Established"
    "Get-Process | Where-Object {`$_.WorkingSet -gt 500MB}"
    "Stop-Process -Name 'ProcessoAlvo' -Force"
    "Get-CimInstance -ClassName Win32_Process | Select-Object Name, CommandLine -First 10"
    "Get-Counter -Counter '\Processor(_Total)\% Processor Time' -MaxSamples 3"
    "Get-CimInstance -ClassName Win32_Bios"
    "Get-Volume"
    "Get-Service | Where-Object {`$_.Status -eq 'Running'} | Select -First 10"
    "Restart-Service -Name 'Spooler' -Force"
    "Get-FileHash -Algorithm SHA256 -Path `$HOME\manual_storage.txt"
    "Get-EventLog -LogName Security -Newest 10"
    "Get-ChildItem -Path `$HOME -Filter *.txt -Recurse -ErrorAction SilentlyContinue"
    "Get-Acl -Path `$HOME | Format-List"
    "Start-Process 'cmd.exe' -ArgumentList '/c echo Ola Janela Louca'"
    "Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 5"
    "Invoke-WebRequest -Uri 'https://ipify.org' -UseBasicParsing | Select-Object -ExpandProperty Content"
    "ComputerDefaults"
    'Start-Process "://bing.com"'
)
foreach ($Cmd in $ComandosPoderosos) { $ListBoxCmds.Items.Add($Cmd) | Out-Null }


# --- COLUNA DIREITA INFERIOR: NOVO BLOCO DE TEXTO MANUAL (COPIAR E COLARES) ---
$L_Manual = New-Object System.Windows.Forms.Label
$L_Manual.Text = '3. BLOCO DE NOTAS / COMANDOS MANUAIS (LER & COPIAR):'
$L_Manual.Location = New-Object System.Drawing.Point(500, 235)
$L_Manual.Size = New-Object System.Drawing.Size(480, 20)
$L_Manual.ForeColor = [System.Drawing.Color]::Orange
$L_Manual.Font = $FntTitulo
$F.Controls.Add($L_Manual)

$TxtManualMenu = New-Object System.Windows.Forms.TextBox
$TxtManualMenu.Multiline = $true
$TxtManualMenu.Location = New-Object System.Drawing.Point(500, 260)
$TxtManualMenu.Size = New-Object System.Drawing.Size(480, 135)
$TxtManualMenu.Font = $FntTexto
$TxtManualMenu.BackColor = [System.Drawing.Color]::FromArgb(25, 20, 20)
$TxtManualMenu.ForeColor = [System.Drawing.Color]::FromArgb(255, 200, 100)
$TxtManualMenu.ScrollBars = 'Vertical'

$TxtManualMenu.Text = @'
=== REVELAR PARÂMETROS DE REDE (WI-FI) ===
(netsh wlan show profiles) | Select-String "\:(.+)$" | ForEach-Object { $name = $_.Matches.Value.Trim(": "); netsh wlan show profile name="$name" key=clear } | Select-String "Nome|Conte|Key"

=== 1. DESCARREGAR ARQUIVO DA WEB (TRANSFERIR) ===
Invoke-WebRequest -Uri "URL_AQUI" -OutFile "$HOME\Downloads\ficheiro.exe"

=== 2. COPIAR PASTA COMPLETA DE FORÇA BRUTA ===
Copy-Item -Path "C:\Origem" -Destination "D:\Destino" -Recurse -Force

=== 3. COMPRIMIR PASTA EM ZIP ===
Compress-Archive -Path "C:\MinhaPasta" -DestinationPath "C:\Backup.zip" -Force

=== 4. EXTRAIR ARQUIVO ZIP ===
Expand-Archive -Path "C:\Backup.zip" -DestinationPath "C:\PastaExtraida" -Force

=== 5. ENCONTRAR ARQUIVOS MODIFICADOS NAS ÚLTIMAS 24H ===
Get-ChildItem -Path "C:\Pasta" -Recurse | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) }

=== 6. LER HARDWARE COMPLETO DO SISTEMA ===
Get-CimInstance -ClassName Win32_ComputerSystem | Format-List TotalPhysicalMemory, Model, Manufacturer, UserName

=== 7. INFORMAÇÃO DETALHADA DO ESPAÇO EM DISCO ===
Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object DeviceID, @{Name="FreeGB";Expression={[math]::round($_.FreeSpace/1GB,2)}}, @{Name="SizeGB";Expression={[math]::round($_.Size/1GB,2)}}

=== 8. ENVIAR TEXTO DIRETO PARA OUTRO PC NA REDE ===
New-NetSession -ComputerName "IP_ALVO"

=== 9. FORÇAR LIMPEZA DE CACHE DNS ===
Clear-DnsClientCache

=== 10. LISTAR PROGRAMAS INSTALADOS NO SISTEMA ===
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
'@
$F.Controls.Add($TxtManualMenu)
# --- PARTE INFERIOR: CONSOLA DE SAÍDA (RESULTADOS) ---
$L3 = New-Object System.Windows.Forms.Label
$L3.Text = '4. CONSOLA DE SAÍDA / HISTÓRICO REAL DE EXECUÇÃO:'
$L3.Location = New-Object System.Drawing.Point(20, 415)
$L3.Size = New-Object System.Drawing.Size(400, 20)
$L3.ForeColor = [System.Drawing.Color]::Lime
$L3.Font = $FntTitulo
$F.Controls.Add($L3)

$OutputConsola = New-Object System.Windows.Forms.TextBox
$OutputConsola.Multiline = $true
$OutputConsola.Location = New-Object System.Drawing.Point(20, 440)
$OutputConsola.Size = New-Object System.Drawing.Size(960, 210)
$OutputConsola.ScrollBars = 'Vertical'
$OutputConsola.ReadOnly = $true
$OutputConsola.BackColor = [System.Drawing.Color]::Black
$OutputConsola.ForeColor = [System.Drawing.Color]::Lime
$OutputConsola.Font = $FntTexto
$F.Controls.Add($OutputConsola)


# --- LÓGICA E EVENTOS DO SCRIPT ---

function Atualizar-Base64 {
    if ([string]::IsNullOrWhiteSpace($InputString.Text)) {
        $OutputBase64.Text = ""
        return
    }
    $Bytes = [System.Text.Encoding]::Unicode.GetBytes($InputString.Text)
    $OutputBase64.Text = [Convert]::ToBase64String($Bytes)
}

$InputString.Add_TextChanged({
    Atualizar-Base64
})
Atualizar-Base64 

# Clique simples para carregar comandos da lista superior
$ListBoxCmds.Add_Click({
    if ($ListBoxCmds.SelectedItem -ne $null) {
        $InputString.Text = $ListBoxCmds.SelectedItem.ToString()
    }
})

# Executar a String digitada como comando nativo real
$BtnExecutar.Add_Click({
    $TextoPuro = $InputString.Text
    if ([string]::IsNullOrWhiteSpace($TextoPuro)) {
        $OutputConsola.Text = "[Erro] Digita ou escolhe um comando primeiro!"
        return
    }

    $OutputConsola.Text = "[Executando comando...]`r`n"
    $F.Refresh()

    try {
        $Resultado = Invoke-Expression $TextoPuro | Out-String
        $OutputConsola.Text = $Resultado
    } 
    catch {
        $OutputConsola.Text = "[ERRO DE SINTAXE]:`r`n$_"
    }
})

# Evento do link do tutorial Base64
$BtnLink.Add_Click({
    [System.Diagnostics.Process]::Start("https://adsecurity.org")
})

# Abrir e renderizar a janela de forma estável
[void]$F.ShowDialog()