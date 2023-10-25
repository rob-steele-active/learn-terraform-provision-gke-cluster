provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_pubsub_topic" "file_ingester_topic" {
  name = "file_ingester_topic"
}

data "google_iam_policy" "file_ingester_publisher" {
  binding {
    role = "roles/pubsub.publisher"
    members = [
      "serviceAccount:robert.steele@activeinternational.com"
    ]
  }
}

resource "google_pubsub_topic_iam_policy" "file-ingester" {
  project     = google_pubsub_topic.file_ingester_topic.project
  topic       = google_pubsub_topic.file_ingester_topic.name
  policy_data = data.google_iam_policy.file_ingester_publisher.policy_data
}
