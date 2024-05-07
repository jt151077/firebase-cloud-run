/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


resource "google_pubsub_topic" "incrementer-topic" {
  depends_on = [
    google_project_service.gcp_services
  ]

  project = local.project_id
  name    = "incrementer"
}

resource "google_eventarc_trigger" "incrementer-trigger" {
  depends_on = [
    google_project_service.gcp_services,
    google_pubsub_topic.incrementer-topic,
    google_cloud_run_service.incrementer_service
  ]

  name     = "incrementer-trigger"
  location = var.project_default_region
  project  = var.project_id

  matching_criteria {
    attribute = "type"
    value     = "google.cloud.pubsub.topic.v1.messagePublished"
  }

  transport {
    pubsub {
      topic = "projects/${local.project_id}/topics/${google_pubsub_topic.incrementer-topic.name}"
    }
  }

  destination {
    cloud_run_service {
      service = google_cloud_run_service.incrementer_service.name
      region  = "europe-west1"
    }
  }
  labels = {
    foo = "bar"
  }
}