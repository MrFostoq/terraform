variable "region" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1a"
}

variable "amiId" {
  type = map(any)
  default = {
    us-east-1 = "ami-04b4f1a9cf54c11d0"
    us-east-2 = "ami-0cb91c7de36eed2cb"
  }
}
