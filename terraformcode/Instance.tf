resource "aws_instance" "web" {
  ami                    = var.amiId[var.region]
  instance_type          = "t3.micro"
  key_name               = "fostoq-key"
  availability_zone      = var.zone
  vpc_security_group_ids = [aws_security_group.fostoq-sg.id]

  tags = {
    Name    = "fostoq-web"
    Project = "instance"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("fostoqkey")
    host        = self.public_ip
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> privet_ips.txt"
  }

}
resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}


output "hostconfigurationinfo" {
  description = "host configuration info"
  value = {
    private_ip  = aws_instance.web.private_ip
    public_ip   = aws_instance.web.public_ip
    private_dns = aws_instance.web.private_dns
    public_dns  = aws_instance.web.public_dns
  }
}
