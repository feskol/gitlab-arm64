#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Handle CTRL+C
trap ctrl_c INT

ctrl_c() {
    echoWarning "Execution interrupted by user."
    exit 1
}

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN='\033[36m'
RESET="\033[0;39m"

### Helper function for colored output
function prettifyOutputLine() {
    echo ""
    echo -e "$1""$2" "$RESET""$3"
    echo ""
}
function prettifyOutput() {
    echo -e "$1"
    echo "========================================"
    printf "$2\n"
    echo "========================================"
    echo -e "$RESET"
}

# Usage: echoError "Error" "An error occured!"
function echoError() {
    prettifyOutput $RED "❌  $1"
}

function echoWarning() {
    prettifyOutput $YELLOW "⚠️  $1"
}

function echoInfo() {
    prettifyOutput $BLUE "ℹ️  $1"
}

function echoSuccess() {
    prettifyOutput $GREEN "✅  $1"
}

function echoSystem() {
    prettifyOutput $CYAN "$1"
}

# Usage: echoErrorLine "Error" "An error occured!"
function echoErrorLine() {
    prettifyOutputLine $RED "$1" "$2"
}

function echoWarningLine() {
    prettifyOutputLine $YELLOW "$1" "$2"
}

function echoInfoLine() {
    prettifyOutputLine $BLUE "$1" "$2"
}

function echoSuccessLine() {
    prettifyOutputLine $GREEN "$1" "$2"
}

function echoSystemLine() {
    prettifyOutputLine $CYAN "$1" "$2"
}

cleanup() {
    # execute cleanup
    ./helper/cleanup.sh
    echoSystemLine "Cleaning up"
}
