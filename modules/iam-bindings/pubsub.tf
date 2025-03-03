# Pub/Sub関連のIAMバインディング
# Pub/Sub TopicのIAMバインディング
resource "google_pubsub_topic_iam_binding" "topic_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", binding.name))
  }
  
  project = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", each.value.name)[0]
  topic   = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/topics/([^/]+)$", each.value.name)[1]
  role    = each.value.role
  members = each.value.members
}

# Pub/Sub SubscriptionのIAMバインディング
resource "google_pubsub_subscription_iam_binding" "subscription_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", binding.name))
  }
  
  project      = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", each.value.name)[0]
  subscription = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/subscriptions/([^/]+)$", each.value.name)[1]
  role         = each.value.role
  members      = each.value.members
}

# Pub/Sub SchemaのIAMバインディング
resource "google_pubsub_schema_iam_binding" "schema_iam_bindings" {
  for_each = {
    for key, binding in local.resource_bindings :
    key => binding
    if can(regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", binding.name))
  }
  
  project = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", each.value.name)[0]
  schema  = regex("^//pubsub\\.googleapis\\.com/projects/([^/]+)/schemas/([^/]+)$", each.value.name)[1]
  role    = each.value.role
  members = each.value.members
} 