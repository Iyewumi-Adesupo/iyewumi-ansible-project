provider "aws" {
  region  = "us-west-2"
  profile = "sue-ade"
}

provider "vault" {
  token   = "s.YJ1X6olszHvB2mPmUzXKpP61"
  address = "https://crystalpalace.online"
}

data "vault_generic_secret" "db_secret" {
  path = "secret/database"
}