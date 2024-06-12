terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = var.global_settings.inherit_tags ? merge(
    var.global_settings.tags,
    try(var.base_tags, null),
    try(var.tags, null)
  ) : try(var.tags, null)
 
}
