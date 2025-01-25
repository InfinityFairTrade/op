# Configuration
$OP_LOG_FILE = "$env:USERPROFILE\.op_log.txt"
$OP_CONFIG_FILE = "$env:USERPROFILE\.op_config"
$OP_LANG = $env:OP_LANG -or "en"
$OP_MESSAGES_FILE = "$env:USERPROFILE\.op\src\data\messages.json"

# Fonction pour charger les messages internationalisés
function load-messages {
    param (
        [string]$lang,
        [string]$messagesFile
    )
    $messages = Get-Content -Raw -Path $messagesFile | ConvertFrom-Json
    $messages.messages.$lang | ForEach-Object {
        Set-Variable -Name $_.Key -Value $_.Value -Scope Global
    }
}

# Charger les messages internationalisés
load-messages $OP_LANG $OP_MESSAGES_FILE

# Function to open a directory or a file
function op {
    param (
        [switch]$help,
        [switch]$verbose,
        [switch]$dryRun,
        [string]$app,
        [string]$search,
        [switch]$showAliases
    )

    function log {
        param (
            [string]$message
        )
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        "$timestamp - $message" | Out-File -FilePath $OP_LOG_FILE -Append
        if ($verbose) {
            Write-Output "$message"
        }
    }

    function open_with_app {
        param (
            [string]$file,
            [string]$app
        )
        if (Get-Command $app -ErrorAction SilentlyContinue) {
            log "$OPENING_FILE_WITH_APP_MESSAGE $file $app"
            if (-not $dryRun) {
                Start-Process $app $file
            }
        } else {
            log "$APP_NOT_FOUND_MESSAGE $app"
            Write-Output "$APP_NOT_FOUND_MESSAGE $app"
        }
    }

    function open_with_default {
        param (
            [string]$file
        )
        log "$OPENING_FILE_WITH_DEFAULT_APP_MESSAGE $file"
        if (-not $dryRun) {
            Start-Process $file
        }
    }

    function open_directory {
        param (
            [string]$dir
        )
        log "$OPENING_DIRECTORY_MESSAGE $dir"
        if (-not $dryRun) {
            Start-Process explorer.exe $dir
        }
    }

    function open_url {
        param (
            [string]$url
        )
        log "$OPENING_URL_MESSAGE $url"
        if (-not $dryRun) {
            Start-Process $url
        }
    }

    function search_file {
        param (
            [string]$pattern
        )
        $file = Get-ChildItem -Path . -Recurse -Filter "*$pattern*" -File | Select-Object -First 1
        if ($file) {
            log "$FILE_FOUND_MESSAGE $($file.FullName) $pattern"
            open_with_default $file.FullName
        } else {
            log "$NO_FILE_FOUND_MESSAGE $pattern"
            Write-Output "$NO_FILE_FOUND_MESSAGE $pattern"
        }
    }

    function show_aliases {
        Write-Output "$ALIASES_MESSAGE"
        Get-Alias | Where-Object { $_.Name -eq "op" }
    }

    if ($help) {
        Write-Output "$HELP_MESSAGE"
        return
    }

    if ($showAliases) {
        show_aliases
    } elseif ($search) {
        search_file $search
    } elseif ($args.Count -eq 0) {
        # Si aucun argument n'est fourni, ouvrir le répertoire courant
        log "$OPENING_CURRENT_DIRECTORY_MESSAGE"
        open_directory "."
    } else {
        foreach ($arg in $args) {
            if (Test-Path -Path $arg -PathType Container) {
                # Si l'argument est un dossier, l'ouvrir avec Explorer
                open_directory $arg
            } elseif (Test-Path -Path $arg -PathType Leaf) {
                # Si l'argument est un fichier, l'ouvrir avec l'application par défaut ou spécifiée
                if ($app) {
                    open_with_app $arg $app
                } else {
                    open_with_default $arg
                }
            } elseif ($arg -match '^https?://') {
                # Si l'argument est une URL, l'ouvrir avec le navigateur par défaut
                open_url $arg
            } else {
                log "$INVALID_ARGUMENT_MESSAGE $arg"
                Write-Output "$INVALID_ARGUMENT_MESSAGE $arg"
            }
        }
    }
}

# Alias pour la fonction op
Set-Alias -Name op -Value op

# Fonction pour configurer les applications par défaut
function configure-default-apps {
    Write-Output "$CONFIGURE_DEFAULT_APPS_MESSAGE"
    $txt_app = Read-Host "$ENTER_DEFAULT_APP_FOR_TXT"
    $pdf_app = Read-Host "$ENTER_DEFAULT_APP_FOR_PDF"
    $doc_app = Read-Host "$ENTER_DEFAULT_APP_FOR_DOC"

    Add-Content -Path $OP_CONFIG_FILE -Value "`$env:OP_DEFAULT_TXT_APP='$txt_app'"
    Add-Content -Path $OP_CONFIG_FILE -Value "`$env:OP_DEFAULT_PDF_APP='$pdf_app'"
    Add-Content -Path $OP_CONFIG_FILE -Value "`$env:OP_DEFAULT_DOC_APP='$doc_app'"

    . $OP_CONFIG_FILE
}

# Appeler la fonction de configuration si nécessaire
if (-not (Test-Path -Path $OP_CONFIG_FILE)) {
    configure-default-apps
}
