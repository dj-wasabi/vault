backend "consul" {
  address = "192.168.99.100:8500"
  path = "vault"
  advertise_addr = "http://192.168.99.100"
}

listener "tcp" {
 address = "0.0.0.0:8200"
 tls_disable = 1
}

disable_mlock = true
