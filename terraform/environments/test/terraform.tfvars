global = {
  namespace = "wowcher"
  stack     = "app"
  delimiter = "-"
  name      = ""
}

region = "eu-west-1"

tags = {
  owner       = "team"
  email       = "team@wowcher.co.uk"
  project     = "testapp"
  costcentre  = "test"
  live        = "no"
  environment = "test"
}

vpc_name = "test-vpc"

private_subnet_cidrs = ["10.20.30.0/24", "10.20.31.0/24"]

public_subnet_cidrs = ["10.20.32.0/24", "10.20.33.0/24"]

cert_name = "test-cert"

domain = "test.wowcher.co.uk"
