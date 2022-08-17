variable "instance_type" {
 type = string
 description = "EC2 instance type"
}

variable "tags-name" {
 type = string
 description = "The name of the VM"
}

variable "tags-descr" {
 type = string
 description = "The description of the VM"
}

variable "ami" {
 type = string
 description = "The description of the VM"
}

variable "tags-env" {
 type = string
 description = "The environment of the VM"
}

variable "tags-owner" {
 type = string
 description = "The owner of the VM"
}
