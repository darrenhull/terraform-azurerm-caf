global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evg_examples = {
    name   = "eventgrid"
  }
}

eventgrid_namespaces = {
  egn1 = {
    name = "egn1"
    resource_group = {
      key = "evg_examples"
    }
    sku_name    = "Standard"
    sku_count   = 1
    is_zone_redundant = false
    public_network_access = "Enabled"

    tags = {
      Contributor = "Hull"
    }

     identity = {
      type = "UserAssigned" 
     }
  }
}


eventgrid_namespace_topics = {
  egnt1 = {
    name = "egnt1"
    eventgrid_namespace = {
      key = "egn1"
    }
    event_retention_days = 7
  }
}



eventgrid_namespace_topic_subscriptions = {
  egnts1 = {
    name = "egnts1"
    eventgrid_namespace_topic  = {
      key = "egnt1"
    }
    event_time_to_live = 7
  }
}