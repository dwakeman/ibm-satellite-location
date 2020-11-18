
variable "satellite_location_name" {
    default = "des-moines"
}

variable "availability_zone_1" {
    default = "us-east-2a"
}

variable "availability_zone_2" {
    default = "us-east-2b"
}

variable "availability_zone_3" {
    default = "us-east-2c"
}

variable "key_name" {
    default = "Samaritan"
}

variable "control_plane_ami" {
#    default = "ami-005b7876121b7244d"
    default = "ami-0d2bf41df19c4aac7"
}

#The one in the default field is what Jake used.  When I searched in AWS using the name he provided I found this one:
# AMI Name: RHEL-7.9_HVM_GA-20200917-x86_64-0-Hourly2-GP2
# AMI ID: ami-0d2bf41df19c4aac7
variable "worker_ami" {
#    default = "ami-005b7876121b7244d"
    default = "ami-0d2bf41df19c4aac7"
}

variable "control_plane_instance_type" {
    default = "t3.xlarge"
}

variable "worker_instance_type" {
    default = "t3.xlarge"
}