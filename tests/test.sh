#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# include helpers and preparation
source ./helper/helper.sh

######################################
# Check if this script is running through docker
######################################
parent_name=$(basename "$(realpath ../)")
if [[ "$parent_name" != "feskol_gitlab_arm64_docker_app_tests" ]]; then
    echoError "Please run this script with: docker compose run --rm -it test"
    exit 1
fi

# execute cleanup
cleanup

# Prompt for full cleanup
read -p "Would you like to perform a full cleanup before continuing? (y/n): " cleanup_choice

if [[ "$cleanup_choice" == "y" || "$cleanup_choice" == "Y" ]]; then
    echoSystemLine "Performing full cleanup..."
    ./helper/full-cleanup.sh
else
    echoSystemLine "Skipping cleanup. Continuing with script execution."
fi

# Retrieve the scripts
source ./scripts.sh

echoSuccessLine "\n------------- available scripts ------------------"
for script in "${SCRIPTS[@]}"; do
    echo "$script"
done
echoSuccessLine "-------------------------------------------------\n"

# Ask for user input
read -p "Enter script name to test (or press Enter to run all scripts): " input_script

# Function to execute a script
run_script() {
    script_name=$1
    echoInfoLine "Running" "$script_name..."

    export ORIGINAL_SCRIPT="../scripts/$script_name"

    # Execute the script and check for errors
    ./$script_name
    if [ $? -eq 0 ]; then
        echoSuccessLine "Successfully" "ran $script_name"
    else
        echoError "Error: $script_name failed to run." >&2
        exit 1
    fi
}

if [[ -z "$input_script" ]]; then
    # No input: Run all scripts
    for script in "${SCRIPTS[@]}"; do
        run_script "$script"
    done

    # Success message
    echoSuccess "All scripts completed successfully."
else
    # Run only the specified script
    # shellcheck disable=SC2199
    if [[ " ${SCRIPTS[@]} " =~ " $input_script " ]]; then
        run_script "$input_script"
    else
        echoError "Error: Script '$input_script' not found in the list."
        exit 1
    fi
fi
