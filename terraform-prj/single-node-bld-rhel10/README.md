📝 Notes
The AMI lookup uses a filter for RHEL images. You may need to adjust the AMI owner ID depending on your AWS region.

The instance is deployed in a public subnet with a public IP and SSH open to the world.
For production, restrict SSH to your IP range.

######################################################

🚀 Single RHEL EC2 Build with Terraform  
A simple, reproducible Terraform configuration that deploys a single RHEL EC2 instance with a public IP, SSH access, and minimal AWS infrastructure (VPC, subnet, route table, IGW, security group).  

This project is ideal for learning Terraform, testing automation, or bootstrapping a small lab environment.  

######################################################

📦 Prerequisites  
Before using this Terraform build, ensure you have:  

Terraform ≥ 1.5  

AWS CLI configured with valid credentials  
aws configure  
An existing AWS key pair  

(or create one on terminal)    

aws ec2 create-key-pair --key-name my-keypair \  
  --query "KeyMaterial" --output text > my-keypair.pem  
chmod 600 my-keypair.pem  

A working AWS account with permissions to create:  

VPC  
Subnets  
Internet Gateway  
Route Tables  
EC2 Instances  
Security Groups  

📁 Project Structure   
single-node-bld-rhel10/  
├── main.tf  
├── variables.tf  
├── outputs.tf  
└── README.md  
  
⚙️ Usage  
1. Clone the repository    
    #git clone https://github.com/<your-user>/<your-repo>.git  
    #cd single-node-bld-rhel10  

2. Initialize Terraform  
   #terraform init  

3. Review the execution plan  
   #terraform plan  

4. Deploy the infrastructure  
   #terraform apply  

Type "yes" when prompted.  


After a successful apply, Terraform will output the public IP:  

output should display:  
rhel10_public_ip = "34.xx.xx.xx"  

###############################################  

🔐 SSH Access  
Once the instance is deployed, connect using your key pair:  


  #ssh -i my-keypair.pem ec2-user@$(terraform output -raw rhel10_public_ip)  
  Or manually:  

  #ssh -i my-keypair.pem ec2-user@34.xx.xx.xx  

Default username for RHEL on AWS:  
ec2-user  

###############################################  

🧹 Destroying the Environment  
To remove all resources created by this project:  
  #terraform destroy  

Type "yes" when prompted.  

