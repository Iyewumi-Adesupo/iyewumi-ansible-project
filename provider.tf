provider "aws" {
  region  = "us-west-2"
  profile = "aws-cli-credentials-name"
}

provider "vault" {
  token   = "vault-generated-token"
  address = "https://domain-name.com"
}

data "vault_generic_secret" "db_secret" {
  path = "secret/database"
}
