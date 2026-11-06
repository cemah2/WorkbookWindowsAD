variable "pve_endpoint"    { type = string }                       # ex: https://10.10.0.2:8006/
variable "pve_api_token"   { type = string, sensitive = true }      # user@pam!tf=xxxx
variable "node_name"       { type = string, default = "pve" }
variable "win_template_id" { type = number }                        # VM ID du template Windows
