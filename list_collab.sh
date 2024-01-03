#!/bin/bash

# GitHub username
USERNAME="<YOUR_USERNAME>"

# Personal access token (generate one from GitHub settings)
TOKEN="<YOUR_ACCESS_TOKEN>"

# Repository name
REPO="<REPOSITORY_NAME>"

# GitHub API endpoint
API_ENDPOINT="https://api.github.com/repos/$USERNAME/$REPO/collaborators"

# Function to list collaborators
list_collaborators() {
    echo "Listing collaborators for $USERNAME/$REPO:"
    curl -s -u "$USERNAME:$TOKEN" "$API_ENDPOINT" | jq -r '.[].login'
}

# Function to add collaborator
add_collaborator() {
    read -p "Enter the GitHub username to add as a collaborator: " new_collaborator
    curl -s -u "$USERNAME:$TOKEN" -X PUT -d '{}' "$API_ENDPOINT/$new_collaborator"
    echo "Collaborator $new_collaborator added successfully."
}

# Function to delete collaborator
delete_collaborator() {
    read -p "Enter the GitHub username to remove as a collaborator: " remove_collaborator
    curl -s -u "$USERNAME:$TOKEN" -X DELETE "$API_ENDPOINT/$remove_collaborator"
    echo "Collaborator $remove_collaborator removed successfully."
}

# Main menu
while :
do
    echo "1. List Collaborators"
    echo "2. Add Collaborator"
    echo "3. Delete Collaborator"
    echo "4. Quit"
    read -p "Enter your choice: " choice

    case $choice in
        1) list_collaborators;;
        2) add_collaborator;;
        3) delete_collaborator;;
        4) echo "Exiting..."; exit 0;;
        *) echo "Invalid choice. Please try again.";;
    esac
done
