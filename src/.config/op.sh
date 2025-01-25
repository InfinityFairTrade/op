#!/bin/zsh

# Configuration
OP_LOG_FILE="${OP_LOG_FILE:-$HOME/.op_log.txt}"
OP_CONFIG_FILE="${OP_CONFIG_FILE:-$HOME/.op_config}"
OP_LANG="${OP_LANG:-en}"
OP_MESSAGES_FILE="$HOME/.op/src/data/messages.json"

# Fonction pour charger les messages internationalisés
load_messages() {
  local lang=$1
  local messages_file=$2
  local messages=$(jq -r ".messages.$lang" "$messages_file")
  eval "$messages"
}

# Charger les messages internationalisés
load_messages "$OP_LANG" "$OP_MESSAGES_FILE"

# Fonction pour ouvrir un dossier ou un fichier
op() {
  local app=""
  local dry_run=false
  local search=""
  local verbose=false
  local show_aliases=false

  # Options
  while getopts ":hvda:s:" opt; do
    case $opt in
      h)
        echo -e "\e[32m$HELP_MESSAGE\e[0m"
        return 0
        ;;
      v)
        verbose=true
        ;;
      d)
        dry_run=true
        ;;
      a)
        app=$OPTARG
        ;;
      s)
        search=$OPTARG
        ;;
      \?)
        echo -e "\e[31m$INVALID_OPTION_MESSAGE $OPTARG\e[0m" >&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND - 1))

  # Logging function
  log() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$OP_LOG_FILE"
    if [ "$verbose" = true ]; then
      echo -e "\e[34m$message\e[0m"
    fi
  }

  # Function to open with a specific application
  open_with_app() {
    local file=$1
    local app=$2
    if command -v "$app" >/dev/null 2>&1; then
      log "$OPENING_FILE_WITH_APP_MESSAGE $file $app"
      if [ "$dry_run" = false ]; then
        "$app" "$file"
      fi
    else
      log "$APP_NOT_FOUND_MESSAGE $app"
      echo -e "\e[31m$APP_NOT_FOUND_MESSAGE $app\e[0m"
    fi
  }

  # Function to open with default application
  open_with_default() {
    local file=$1
    if command -v xdg-open >/dev/null 2>&1; then
      log "$OPENING_FILE_WITH_DEFAULT_APP_MESSAGE $file"
      if [ "$dry_run" = false ]; then
        xdg-open "$file"
      fi
    elif command -v open >/dev/null 2>&1; then
      log "$OPENING_FILE_WITH_DEFAULT_APP_MESSAGE $file"
      if [ "$dry_run" = false ]; then
        open "$file"
      fi
    else
      log "$NO_DEFAULT_OPEN_COMMAND_MESSAGE"
      echo -e "\e[31m$NO_DEFAULT_OPEN_COMMAND_MESSAGE\e[0m"
    fi
  }

  # Function to open a directory
  open_directory() {
    local dir=$1
    if command -v xdg-open >/dev/null 2>&1; then
      log "$OPENING_DIRECTORY_MESSAGE $dir"
      if [ "$dry_run" = false ]; then
        xdg-open "$dir"
      fi
    elif command -v open >/dev/null 2>&1; then
      log "$OPENING_DIRECTORY_MESSAGE $dir"
      if [ "$dry_run" = false ]; then
        open "$dir"
      fi
    else
      log "$NO_DEFAULT_OPEN_COMMAND_MESSAGE"
      echo -e "\e[31m$NO_DEFAULT_OPEN_COMMAND_MESSAGE\e[0m"
    fi
  }

  # Function to open a URL
  open_url() {
    local url=$1
    if command -v xdg-open >/dev/null 2>&1; then
      log "$OPENING_URL_MESSAGE $url"
      if [ "$dry_run" = false ]; then
        xdg-open "$url"
      fi
    elif command -v open >/dev/null 2>&1; then
      log "$OPENING_URL_MESSAGE $url"
      if [ "$dry_run" = false ]; then
        open "$url"
      fi
    else
      log "$NO_DEFAULT_OPEN_COMMAND_MESSAGE"
      echo -e "\e[31m$NO_DEFAULT_OPEN_COMMAND_MESSAGE\e[0m"
    fi
  }

  # Function to search for a file pattern
  search_file() {
    local pattern=$1
    local file=$(find . -type f -name "*$pattern*" 2>/dev/null | head -n 1)
    if [ -n "$file" ]; then
      log "$FILE_FOUND_MESSAGE $file $pattern"
      open_with_default "$file"
    else
      log "$NO_FILE_FOUND_MESSAGE $pattern"
      echo -e "\e[31m$NO_FILE_FOUND_MESSAGE $pattern\e[0m"
    fi
  }

  # Function to show aliases
  show_aliases() {
    echo -e "\e[32m$ALIASES_MESSAGE\e[0m"
    alias | grep 'alias op='
  }

  # Main logic
  if [ "$show_aliases" = true ]; then
    show_aliases
  elif [ "$search" ]; then
    search_file "$search"
  elif [ $# -eq 0 ]; then
    # Si aucun argument n'est fourni, ouvrir le répertoire courant
    log "$OPENING_CURRENT_DIRECTORY_MESSAGE"
    open_directory "."
  else
    for arg in "$@"; do
      if [ -d "$arg" ]; then
        # Si l'argument est un dossier, l'ouvrir avec l'application par défaut
        open_directory "$arg"
      elif [ -f "$arg" ]; then
        # Si l'argument est un fichier, l'ouvrir avec l'application par défaut ou spécifiée
        if [ -n "$app" ]; then
          open_with_app "$arg" "$app"
        else
          open_with_default "$arg"
        fi
      elif [[ "$arg" =~ ^https?:// ]]; then
        # Si l'argument est une URL, l'ouvrir avec le navigateur par défaut
        open_url "$arg"
      else
        log "$INVALID_ARGUMENT_MESSAGE $arg"
        echo -e "\e[31m$INVALID_ARGUMENT_MESSAGE $arg\e[0m"
      fi
    done
  fi
}

# Alias pour la fonction op
alias op='op'

# Fonction pour configurer les applications par défaut
configure_default_apps() {
  echo -e "\e[32m$CONFIGURE_DEFAULT_APPS_MESSAGE\e[0m"
  read -p "$ENTER_DEFAULT_APP_FOR_TXT: " txt_app
  read -p "$ENTER_DEFAULT_APP_FOR_PDF: " pdf_app
  read -p "$ENTER_DEFAULT_APP_FOR_DOC: " doc_app

  echo "export OP_DEFAULT_TXT_APP=$txt_app" >> "$OP_CONFIG_FILE"
  echo "export OP_DEFAULT_PDF_APP=$pdf_app" >> "$OP_CONFIG_FILE"
  echo "export OP_DEFAULT_DOC_APP=$doc_app" >> "$OP_CONFIG_FILE"

  source "$OP_CONFIG_FILE"
}

# Appeler la fonction de configuration si nécessaire
if [ ! -f "$OP_CONFIG_FILE" ]; then
  configure_default_apps
fi
