variable "credentials" {
  description = "My Credentials"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "europe-west1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default = "zoomcamp_de_411412_demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default = "zoomcamp-de-411412-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}