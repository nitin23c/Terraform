output "demo_ec2_ip" {
  value = aws_instance.demo_ec2.public_ip
}

output "my_public_ip_address" {
  value = data.http.myip.response_body
}