variable "region" {
    default = "us-east-1"
}


variable "os_name" {
    default = "ami-053b0d53c279acc90"
}


variable "key" {
    default = "Demoo"
}


variable "instance-type" {
    default = "t2.micro"
}


variable "vpc-cidr" {
    default = "10.10.0.0/16"  
}


variable "subnet1-cidr" {
    default = "10.10.1.0/24"
  
}
variable "subent_az" {
    default =  "us-east-1"  
}
