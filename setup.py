import os
import platform
import subprocess
import sys
import time
import json

def detect_platform():
    system = platform.system()
    if system == "Linux":
        return "linux"
    elif system == "Darwin":
        return "macos"
    elif system == "Windows":
        return "windows"
    else:
        print("Plateforme non supportée.")
        sys.exit(1)

def create_config_file():
    op_config_file = os.path.expanduser("~/.op_config")
    op_log_file = os.path.expanduser("~/.op_log.txt")
    with open(op_config_file, "w") as config_file:
        config_file.write(f"# Configuration pour op\nOP_LOG_FILE={op_log_file}\nOP_LANG=en\n")
    open(op_log_file, "a").close()

def copy_config_files():
    home_dir = os.path.expanduser("~")
    op_dir = os.path.join(home_dir, ".op", "src", ".config")
    os.makedirs(op_dir, exist_ok=True)
    os.makedirs(os.path.join(home_dir, ".op", "src", "data"), exist_ok=True)
    subprocess.run(["cp", "src/.config/op.sh", op_dir], check=True)
    subprocess.run(["cp", "src/.config/op.ps1", op_dir], check=True)
    subprocess.run(["cp", "src/data/messages.json", os.path.join(home_dir, ".op", "src", "data")], check=True)

def add_function_to_shell(platform):
    home_dir = os.path.expanduser("~")
    if platform == "linux":
        shell_config = os.path.expanduser("~/.bashrc")
        if not os.path.exists(shell_config):
            shell_config = os.path.expanduser("~/.zshrc")
        with open(shell_config, "a") as config_file:
            config_file.write(f"source {home_dir}/.op/src/.config/op.sh\n")
    elif platform == "macos":
        shell_config = os.path.expanduser("~/.zshrc")
        if not os.path.exists(shell_config):
            shell_config = os.path.expanduser("~/.bashrc")
        with open(shell_config, "a") as config_file:
            config_file.write(f"source {home_dir}/.op/src/.config/op.sh\n")
    elif platform == "windows":
        profile_path = os.path.expanduser(r"~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")
        if not os.path.exists(profile_path):
            open(profile_path, "a").close()
        with open(profile_path, "a") as config_file:
            config_file.write(f"{home_dir}\\.op\\src\\.config\\op.ps1\n")

def configure_interactive():
    print("\033[32mBienvenue dans l'assistant de configuration de op!\033[0m")
    print("\033[34mVeuillez suivre les instructions pour configurer les applications par défaut pour certains types de fichiers.\033[0m")

    txt_app = input("Entrez l'application par défaut pour les fichiers .txt: ")
    pdf_app = input("Entrez l'application par défaut pour les fichiers .pdf: ")
    doc_app = input("Entrez l'application par défaut pour les fichiers .doc: ")

    op_config_file = os.path.expanduser("~/.op_config")
    with open(op_config_file, "a") as config_file:
        config_file.write(f"export OP_DEFAULT_TXT_APP={txt_app}\n")
        config_file.write(f"export OP_DEFAULT_PDF_APP={pdf_app}\n")
        config_file.write(f"export OP_DEFAULT_DOC_APP={doc_app}\n")

    os.system(f"source {op_config_file}")

def show_progress():
    print("\033[33mInstallation en cours...\033[0m")
    time.sleep(1)
    print("\033[33mCopie des fichiers de configuration...\033[0m")
    time.sleep(1)
    print("\033[33mAjout de la fonction au fichier de configuration shell...\033[0m")
    time.sleep(1)
    print("\033[33mConfiguration interactive...\033[0m")
    time.sleep(1)
    print("\033[32mInstallation terminée!\033[0m")

def main():
    platform = detect_platform()
    create_config_file()
    copy_config_files()
    add_function_to_shell(platform)
    configure_interactive()
    show_progress()
    print("Veuillez recharger votre fichier de configuration shell.")

if __name__ == "__main__":
    main()
