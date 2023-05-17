
data "aws_route53_zone" "arman_rebrain" {
  name         = "devops.rebrain.srwx.net"
  
 
 }





resource "aws_route53_record" "arman_devops_rebrain_srwx_net2" {
  count = "${length( keys(var.devs))}"
  zone_id = data.aws_route53_zone.arman_rebrain.zone_id 
   name    = "${element(values(var.devs), count.index)}.${data.aws_route53_zone.arman_rebrain.name}"
  type    = "A"
  ttl     = "300"
  records = [digitalocean_droplet.vm[count.index].ipv4_address]
 
}

