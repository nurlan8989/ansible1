resource "local_file" "ansible_inventory" {
  content  = "${digitalocean_droplet.web.name}  ansible_host=${digitalocean_droplet.web.ipv4_address} ansible_user=root ansible_ssh_private_key_file=/home/rebrain/.ssh/do_key"
  filename = "ansible_inventory"
}


resource "local_file"  "virthost" {
  count    = 2
  content  = "server {\n listen 80;\n server_name ${aws_route53_record.route53_record[count.index].fqdn};\n location / { return 200 ' {{ ansible_hostname }} {{ ansible_os_family }}  ${count.index + 1}\n' ;}\n}"
  filename = "./templates/site_${count.index + 1}.conf.j2"
}


