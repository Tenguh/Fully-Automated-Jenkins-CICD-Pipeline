# Fully-Automated-Jenkins-CICD-Pipeline
✅ Step 1: Launch Jenkins on EC2 via AWS Console
1. Launch EC2 Instance
Go to EC2 > Launch Instance
Name: jenkins-master
AMI: amazon linux 2023 AMI
Instance Type: t2.medium 
Key Pair: Create or use existing key pair (for SSH)
Network Settings:
VPC: default or your custom
Subnet: any public subnet
Auto-assign Public IP: Enabled
Security Group: Create new one:
SSH → Port 22 → Source: My IP
HTTP → Port 80 → Source: 0.0.0.0/0
Custom TCP → Port 8080 → Source: 0.0.0.0/0 (for Jenkins)
Click Launch Instance

2. Install Jenkins on the EC2 Instance
SSH into the instance
![](ssh.png)
Then install Jenkins with the following commands
```
sudo yum update -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

sudo yum install
 java-17-amazon-corretto -y

sudo yum install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins
```




**3.** connect to jenkins 
in other to connect to jenkins, make sure:
- Jenkins is running
- Port 8080 is listening
- Security group allows inbound traffic on port 8080
use the public ip of your server and the jenkins port to connect to jenkins from the browser ****publicip:port number****
![](jenkinsui-1.png)

Use the var/lib path to get the jenkins password from the terminal using the command 


```
sudo cat < /var/lib/jenkins/secrets/initialAdminPassword>
``` 

copy the password and paste in the jenkins ui and click on continue
![](uipassword-2.png)
click on install suggested plugins
create your first admin user by providing
username --> master
password --> master
email address --> tenguhh@yahoo.com
click on **save and continue**
click **save and finish**
click on **start using jenkins**

**4** Install Plugins
Maven
go to manage Jenkins
click on tools
scroll right to the bottom
click on  Add Maven
give it a name maven-3.6
click the dropdown and select the version as 3.6.0
click on apply and save
![](maven.png)

Creating the Jenkinsfile
Stage 1:This stage builds the jar file.
```
#!usr/bin/env groovy
pipeline {
    agent any
    tools{
        maven 'maven-3.6'
    }
    stages{
        stage(build app){
            steps{
                script{
                    echo"building the application"
                    sh "mvn clean package" 
                }
            }
        }
    }
}
```