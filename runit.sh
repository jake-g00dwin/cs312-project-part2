#!/bin/bash
# Author: Jake G
# Date: 2024
# Filename: runit.sh


function test_terraform () {
    echo "Now tesing Terrform..."
    sleep 2
    cd ./src
    terraform init && terraform fmt && terraform apply
    cd ../
}

function destroy_terraform () {
    read -p "Hit Enter to Destroy Terraform:"
    cd ./src
    terraform destroy
    cd ../
}

test_terraform

