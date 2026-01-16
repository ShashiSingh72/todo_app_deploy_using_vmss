resource "azurerm_monitor_data_collection_rule" "collection_rule" {
    for_each = var.data_collection_rules
  name                        = each.value.data_collection_rule_name
  resource_group_name         = each.value.resource_group_name
  location                    = each.value.location
#   data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.example.id

  destinations {
    log_analytics {
      workspace_resource_id = data.azurerm_log_analytics_workspace.analytics_workspace[each.key].id
      name                  = "crule-destination-log"
    }

    # event_hub {
    #   event_hub_id = azurerm_eventhub.example.id
    #   name         = "collection_rule-destination-eventhub"
    # }

    storage_blob {
      storage_account_id = data.azurerm_storage_account.data_stg[each.key].id
      container_name     = data.azurerm_storage_container.data_stg_container[each.key].name
      name               = "crule-destination-storage"
    }

    azure_monitor_metrics {
      name = "crule-destination-metrics"
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["crule-destination-metrics"]
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
    destinations = ["crule-destination-log"]
  }

  data_flow {
    streams       = ["Custom-MyTableRawData"]
    destinations  = ["crule-destination-log"]
    output_stream = "Microsoft-Syslog"
    transform_kql = "source | project TimeGenerated = Time, Computer, Message = AdditionalContext"
  }

  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "crule-datasource-syslog"
      streams        = ["Microsoft-Syslog"]
    }

    # iis_log {
    #   streams         = ["Microsoft-W3CIISLog"]
    #   name            = "collection_rule-datasource-iis"
    #   log_directories = ["C:\\Logs\\W3SVC1"]
    # }

    log_file {
      name          = "crule-datasource-logfile"
      format        = "text"
      streams       = ["Custom-MyTableRawData"]
      file_patterns = ["/var/log/java/*.log"] 
      settings {
        text {
          record_start_timestamp_format = "ISO 8601"
        }
      }
    }

    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["Processor(*)\\% Processor Time"]
      name                          = "crule-datasource-perfcounter"
    }

    # windows_event_log {
    #   streams        = ["Microsoft-WindowsEvent"]
    #   x_path_queries = ["*![System/Level=1]"]
    #   name           = "crule-datasource-wineventlog"
    # }

    # extension {
    #   streams            = ["Microsoft-WindowsEvent"]
    #   input_data_sources = ["crule-datasource-wineventlog"]
    #   extension_name     = "crule-extension-name"
    #   extension_json = jsonencode({
    #     a = 1
    #     b = "hello"
    #   })
    #   name = "crule-datasource-extension"
    # }
  }

  stream_declaration {
    stream_name = "Custom-MyTableRawData"
    column {
      name = "Time"
      type = "datetime"
    }
    column {
      name = "Computer"
      type = "string"
    }
    column {
      name = "AdditionalContext"
      type = "string"
    }
  }

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.example.id]
#   }

#   description = "data collection rule example"
#   tags = {
#     foo = "bar"
#   }
}

resource "azurerm_virtual_machine_scale_set_extension" "ama" {
  for_each = var.data_collection_rules

  name                         = "AzureMonitorLinuxAgent"
  virtual_machine_scale_set_id = data.azurerm_virtual_machine_scale_set.data_vmss[each.key].id

  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}


resource "azurerm_monitor_data_collection_rule_association" "vmss_assoc" {
    for_each = var.data_collection_rules
  name                    = "vmss-dcr-association"
  target_resource_id      = data.azurerm_virtual_machine_scale_set.data_vmss[each.key].id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.collection_rule[each.key].id
}

