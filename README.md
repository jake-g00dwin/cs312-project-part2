# cs312-project-part2


Background: What will we do? How will we do it? 
Requirements:
What will the user need to configure to run the pipeline?
What tools should be installed?
Are there any credentials or CLI required?
Should the user set environment variables or configure anything?
Diagram of the major steps in the pipeline. 
List of commands to run, with explanations.
How to connect to the Minecraft server once it's running?


## Background

### What we will do

* Clone a repo.
* open a terminal.
* Install needed tools
* setup a minecraft server
* connect to a minecraft server


### How we will do it

* Using a shell script to start the other tools.
* Using Terraform for the provisioning.
* Using Ansible for the configuration.
* Using Nmap to check the ports of the minecraft server


## Requriements

- A linux machine
- standard cli utilities, like sed and bash
- an internet connection.
- the cli for terraform and aws

## Tools

* AWS CLI 2.0+
* Terraform CLI 1.8.0+
* Bash 5.1.0+
* Ansible 2.10.0+
* ssh 8.9+
* nmap 7.8+
* sed 4.8+

## Credentials

We need to have the user's AWS credentials file in the default
location '~/.aws/credentials'


## Diagram

```
┌───────────────────┐
│                   │
│    SHELL SCRIPT   │
│                   │
└─────────┬─────────┘
          │          
          │          
          ▼          
┌───────────────────┐
│                   │
│   Terraform       │
│                   │
└─────────┬─────────┘
          │          
          │          
          ▼          
┌───────────────────┐
│                   │
│  Ansible Playbook │
│                   │
└─────────┬─────────┘
          │          
          │          
          ▼          
┌───────────────────┐
│                   │
│  NMAP CONNECTION  │
│                   │
└───────────────────┘
```


## Commands to Run

Only one command is needed to run the project assuming you have an AWS account
and your credentials file already setup.

The script will automatically create the needed ssh key for the ec2 instance
and will skip key creation if one is already present in the directory.

```sh
chmod +x ./runit.sh
./runit.sh
```


## How to connect to the Minecraft server

The connection test is carried out via nmap and is contained in the
runit.sh script already


## SOURCES/RESOURCES USED

[ansible docs](https://docs.ansible.com/)
[Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
[Terraform Docs](https://terraform-docs.io/user-guide/introduction/)
[Terraform Auto apply](https://www.educative.io/answers/how-to-use--auto-approve-flag-with-terraform-apply)
[Terraform Auto approve](https://developer.hashicorp.com/terraform/cli/commands/apply)
[Bash ref manual](https://www.gnu.org/software/bash/manual/bash.html)
[ascii flow](https://asciiflow.com/#/)
[AWS CLI ref](https://docs.aws.amazon.com/cli/latest/reference/#available-services)

