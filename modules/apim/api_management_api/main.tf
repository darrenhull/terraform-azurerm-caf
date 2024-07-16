terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  import_from_url = can(regex("-link", var.settings.import.content_format))
  file_name = replace(var.settings.import.content_value, "^/", "") 
}
