locals {
  users = csvdecode(file("users.csv")) // It gives list of maps for the data
}