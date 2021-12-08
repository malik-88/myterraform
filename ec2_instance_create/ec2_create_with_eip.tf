provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA52Zsdsdsdsd"
  secret_key = "dQh6zx08Vk"
}

#### this portion is used for the creation of the aws instance with a tag hello world and malik is the name given by you for the identification of the resource#######
resource "aws_instance" "malik" {
  ami = "ami-041d6256ed0f2061c"
  instance_type = "t2.micro"
  tags = {
    Name= "Hello"
  }
}

####this is used for creation of elastic ip ########
resource "aws_eip" "malikeip" {
  instance = aws_instance.malik.id
  vpc      = true
}

######this module is used for association of eip with the instance where you have to give the name mentioned in the above blocks like malik and malikeip with the syntax to associate it accordingly####
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.malik.id
  allocation_id = aws_eip.malikeip.id
}

####this is a small code to get the output of the above resource which we are using to print or save with a variable name.. for ex: if you give only aws_instance.malik then it will be printing the complete ouput whereas if you want a specific filed as an output then please mention it like aws_instance.malik.public_ip where it will only print the public_ip of the instance#####

output "instance_details" {
  value = aws_instance.malik.public_ip
}

output "eip_details" {
  value = aws_instance.malik
}
