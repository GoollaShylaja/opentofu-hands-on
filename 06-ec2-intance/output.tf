output "instance_url" {
  description = "Public IP URL of the instance"
  value       = "http://${aws_instance.test_instance.public_ip}"

}
/*
PEM format stands for Privacy-Enhanced Mail. It is a common text format used to store cryptographic keys and certificates.

In your OpenTofu example, the private key is stored in PEM format.

It looks something like this:
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFA...
...
-----END PRIVATE KEY-----
*/
output "private_key" {
  description = "SSH Private Key"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}
/*What is <<-EOF?
This is called a heredoc. It allows you to write multiple lines of text inside an output.

Everything between <<-EOF and EOF becomes the output value.
*/

output "ssh_command" {
  description = "SSH command for the lazy"
  value       = <<-EOF
    tofu output -raw private_key > key.pem
    chmod 0600 key.pem
    ssh -i key.pem ec2-user@${aws_instance.test_instance.public_ip}
  EOF
}