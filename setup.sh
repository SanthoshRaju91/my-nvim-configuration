#!/usr/bin/env bash
set -euo pipefail

# Checking if nvim directory exists in ~/.config directory
check_if_nvim_dir_exists() {
    if [[ -d "$HOME/.config/nvim" ]]; then
        return 0
    else
        return 1
    fi
}

copy_nvim_config() {
    cp -R nvim "$HOME/.config/"
}

DESTRUCTIVE_MODE=false

while getopts "d" opt; do
    case $opt in
    d)
        DESTRUCTIVE_MODE=true
        ;;
    esac
done

if $DESTRUCTIVE_MODE; then
    echo "::: In destructive mode, overriding the existing nvim configuration"
    rm -rf "$HOME/.config/nvim"
    copy_nvim_config
    echo "::: Nvim configuration overridden in $HOME/.config/nvim. Happy nvim coding!!!"
else
    if check_if_nvim_dir_exists; then
        echo "::: NVIM configuration already exists in $HOME/.config/nvim. To override run setup.sh -d"
    else
        copy_nvim_config
        echo "::: Nvim configuration copied to $HOME/.config/nvim. Happy nvim coding!!!"
    fi
fi
