 .----------------.  .----------------. 
| .--------------. || .--------------. |
| |     ____     | || |   ______     | |
| |   .'    '.   | || |  |_   __ \   | |
| |  /  .--.  \  | || |    | |__) |  | |
| |  | |    | |  | || |    |  ___/   | |
| |  \  '--'  /  | || |   _| |_      | |
| |   `.____.'   | || |  |_____|     | |
| |              | || |              | |
| '--------------' || '--------------' |
 '----------------'  '----------------' 


# 🚀 Quick File and Directory Opener 🚀

## 🌐 Overview

`op` is a powerful, cross-platform shell command that simplifies file and directory management across macOS, Linux, and Windows. Designed for efficiency and ease of use, `op` allows you to:

- 📂 Open current directories instantly
- 🗂️ Navigate to specific folders with ease
- 📄 Launch files using default or custom applications
- 🕵️ Search for files quickly
- 📋 Track and log all actions
- 🔧 Configure default applications for specific file types
- 📜 Show created aliases

## 🛠 Project Structure
op/
├── src/
│   ├── data/
│   │   ├── messages.json  # JSON file for internationalized messages
│   │   └── .op_log.txt     # Log file
│   ├── .config/
│   │   ├── op.sh           # Central configuration file for macOS and Linux
│   │   ├── op.ps1          # Central configuration file for Windows
│   │   ├── op_setup.sh    # Installation script for macOS and Linux
│   │   └── .op_config      # User configuration file
├── README.md       # Project documentation
├── setup.py        # Main script for installation and configuration


## 🔽 Installation

### 🍎 macOS & 🐧 Linux Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/InfinityFairTrade/op.git
Run the installation script:


cd op
python setup.py
Reload your shell configuration:


# For macOS (Zsh)
source ~/.zshrc

# For Linux (Bash)
source ~/.bashrc
🪟 Windows Installation
Clone the repository:


git clone https://github.com/InfinityFairTrade/op.git
Run the PowerShell installation script:


cd op
python setup.py
🎛️ Command Options
Option	Description
-h	🆘 Display help information
-v	📢 Enable verbose mode
-d	🧪 Dry run mode (simulate actions)
-a <app>	🖥️ Open with a specific application
-s <pattern>	🔍 Search for files by pattern
--show-aliases	🔗 Show created aliases
🌈 Usage Examples
Basic Operations

# Open current directory
op

# Open a specific folder
op /path/to/directory

# Open a file with default application
op /path/to/file
Advanced Usage

# Open file with specific application
op -a "Visual Studio Code" /path/to/file

# Verbose mode
op -v /path/to/file

# Dry run mode
op -d /path/to/file

# Search for a file
op -s "myDocument"

# Show created aliases
op --show-aliases
📋 Logging
All op actions are automatically logged to:


~/.op_log.txt
🌟 Key Features
🔄 Cross-platform compatibility
🚀 Fast and lightweight
🔍 Powerful search capabilities
📊 Comprehensive logging
🛡️ Dry run and verbose modes
🔧 Configure default applications for specific file types
📜 Show created aliases
📜 License

👥 Contributors
Made with ❤️ by InfinityFairTrade

🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂

▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂


🇫🇷 Français - Documentation de l'Outil op
---

🚀 Ouvreur Rapide de Fichiers et Répertoires 🚀
🌐 Présentation
op est une commande shell puissante et multiplateforme qui simplifie la gestion des fichiers et répertoires sur macOS, Linux et Windows. Conçu pour l'efficacité et la facilité d'utilisation, op vous permet de :

📂 Ouvrir instantanément les répertoires courants
🗂️ Naviguer facilement vers des dossiers spécifiques
📄 Lancer des fichiers avec l'application par défaut ou personnalisée
🕵️ Rechercher rapidement des fichiers
📋 Suivre et enregistrer toutes les actions
🔧 Configurer les applications par défaut pour certains types de fichiers
📜 Afficher les alias créés
🛠 Structure du Projet

op/
├── src/
│   ├── data/
│   │   ├── messages.json  # Fichier JSON pour les messages internationalisés
│   │   └── .op_log.txt     # Fichier de log
│   ├── .config/
│   │   ├── op.sh           # Fichier de configuration centralisé pour macOS et Linux
│   │   ├── op.ps1          # Fichier de configuration centralisé pour Windows
│   │   ├── op_setup.sh    # Script d'installation pour toutes les plateformes
│   │   └── .op_config      # Fichier de configuration utilisateur
├── README.md       # Fichier README
├── setup.py        # Script principal pour l'installation et la configuration
🔽 Installation
🍎 macOS & 🐧 Linux Installation
Clonez le dépôt :


git clone https://github.com/InfinityFairTrade/op.git
Exécutez le script d'installation :


cd op
python setup.py
Rechargez la configuration de votre shell :


# Pour macOS (Zsh)
source ~/.zshrc

# Pour Linux (Bash)
source ~/.bashrc
🪟 Installation Windows
Clonez le dépôt :


git clone https://github.com/InfinityFairTrade/op.git
Exécutez le script d'installation PowerShell :


cd op
python setup.py
🎛️ Options de Commande
Option	Description
-h	🆘 Afficher les informations d'aide
-v	📢 Activer le mode verbeux
-d	🧪 Mode d'exécution à sec (simuler les actions)
-a <app>	🖥️ Ouvrir avec une application spécifique
-s <pattern>	🔍 Rechercher des fichiers par motif
--show-aliases	🔗 Afficher les alias créés
🌈 Exemples d'Utilisation
Opérations de Base

# Ouvrir le répertoire courant
op

# Ouvrir un dossier spécifique
op /chemin/vers/dossier

# Ouvrir un fichier avec l'application par défaut
op /chemin/vers/fichier
Utilisation Avancée

# Ouvrir un fichier avec une application spécifique
op -a "Visual Studio Code" /chemin/vers/fichier

# Mode verbeux
op -v /chemin/vers/fichier

# Mode d'exécution à sec
op -d /chemin/vers/fichier

# Rechercher un fichier
op -s "monDocument"

# Afficher les alias créés
op --show-aliases
📋 Journalisation
Toutes les actions de op sont automatiquement enregistrées dans :


~/.op_log.txt
🌟 Fonctionnalités Principales
🔄 Compatibilité multiplateforme
🚀 Rapide et léger
🔍 Capacités de recherche puissantes
📊 Journalisation complète
🛡️ Modes d'exécution à sec et verbeux
🔧 Configurer les applications par défaut pour certains types de fichiers
📜 Afficher les alias créés
📜 Licence

👥 Contributeurs
Réalisé avec ❤️ par InfinityFairTrade

🤝 Contribution
Les contributions sont les bienvenues ! N'hésitez pas à soumettre une Pull Request.

▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂

 ____ ____ 
||o |||p ||
||__|||__||
|/__\|/__\|


           
