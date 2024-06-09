#!/bin/bash
# Author: Jake G
# Date: 2024
# Filename: runit.sh

KEY_NAME="minecraft-key.pem"
PUBLIC_IP=""

function get_key () {
    echo "Checking for key"

    # Check that there isn't a key already
    if [ -f "./${KEY_NAME}" ]; then
        echo "Key found...skipping"
        return 0
    fi
 
    echo "Generating Key..." 
    aws ec2 create-key-pair --key-name ${KEY_NAME} --query 'KeyMaterial' --output text > ${KEY_NAME}
    chmod 0400 ./${KEY_NAME}
}

function run_terraform () {
    echo "Now tesing Terrform..."
    sleep 2
    cd ./src
    terraform init && terraform fmt && terraform apply -auto-approve
    cd ../
}

function destroy_terraform () {
    read -p "Hit Enter to Destroy Terraform:"
    cd ./src
    terraform destroy
    cd ../
}

function get_public_ip () {
    echo "getting the public IPV4 address.."
    cd ./src
    PUBLIC_IP=$(terraform output | sed 's/^.*= "//' | sed 's/"//')
    echo "PUBLIC_IP=${PUBLIC_IP}"
    cd ../
}

# Not used except for diagnostic purposes
function ssh_into_server () {
    get_public_ip
    ssh -i ./${KEY_NAME} ec2-user@${PUBLIC_IP}
}

function run_playbook () {
    export ANSIBLE_HOSTS="${PUBLIC_IP}"
    ansible-playbook ./setup_minecraft.yaml
}

function nmap_server () {
    nmap -sV -Pn -p T:25565 ${PUBLIC_IP}
}

#get_key
#run_terraform
get_public_ip
run_playbook
#nmap_server

