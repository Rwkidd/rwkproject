## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Diagrams/diagram_network.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: Enter the playbook file._ ---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module (It will default to pip3)
    - name: Install Docker module
      pip:
        name: docker
        state: present

      # Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

      # Use sysctl module
    - name: vm.max_map_count
      sysctl:
        name: vm.max_map_count
        value: '262144'
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly ____, in addition to managing _____ to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_ Load Balancer: Protection against DDOS, Jump Box improves security by having users connect to it first before being able to access other machines on the network

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _____ and system _____.
- _TODO: What does Filebeat watch for?_ centralizing log data
- _TODO: What does Metricbeat record?_ metric data

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
|          |          | 20.211.4.85|Public IP of Jump box
| WEB1     |    VM    | 10.0.0.10  | Linux            |
| WEB2     |    VM    | 10.0.0.9   | Linux            |
| ELK      | Monitor  | 10.0.1.7   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _____ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_ 10.0.0.10 10.0.0.9 10.0.1.7

Machines within the network can only be accessed by _____.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_ Jump Box 10.0.0.4/20.211.4.85

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 10.0.0.10 10.0.0.9   |
| Web1/Web2| No                  | 10.0.0.4             |
|    Elk   | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_ 
    It allows you to quickly and easily deploy multitier applications to your network
The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Install Docker
- Install pip3
- Install Docker pyhton module
- Increase Virtual Memory
- Download and launch Docker/pip3

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Diagrams/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_
10.0.0.10, 10.0.0.9
We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_
File Beat, Metric Beat
These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
    Filebeat monitors log files and collects log events and forwards them to be indexed
    Metricbeat collects metrics from your machines such as log in data, and data related to server services
### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_ install-elk.yml, Ansible Control Node
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_ ansible-playbook installelk.yml, setting group names in the hosts file and adding the ips of the machines to the groups you wish to install them to, then you specify the host in the .yml file
- _Which URL do you navigate to in order to check that the ELK server is running? Kibana
_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._ 
Edit host file to have private IP addresses of the VMs you want the playbook to run through example=
[webservers]
10.0.0.10 ansible_python_interpreter=/usr/bin/python3
Create .yml playbook with commands to install Docker, pip3, elk, DVWA containers etc.
To run playbook:ansible-playbook <filename>.yml
Check if succesful either through DVWA or Kibana