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

resource "google_cloud_run_service" "incrementer_service" {
  depends_on = [
    google_project_service.gcp_services
  ]

  name     = var.incrementer_service
  project  = var.project_id
  location = var.project_default_region

  metadata {
    annotations = {
      "run.googleapis.com/ingress" : "all"
    }
  }

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email
      containers {
        image = var.default_run_image

        ports {
          container_port = 80
        }

        env {
          name  = "PROJECT_ID"
          value = local.project_id
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].spec[0].service_account_name,
      metadata[0].annotations["run.googleapis.com/operation-id"],
      metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"]
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


resource "google_cloud_run_service" "frontend_service" {
  depends_on = [
    google_project_service.gcp_services
  ]

  name     = var.frontend_service
  project  = var.project_id
  location = var.project_default_region

  metadata {
    annotations = {
      "run.googleapis.com/ingress" : "all"
    }
  }

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email
      containers {
        image = var.default_run_image

        ports {
          container_port = 80
        }

        env {
          name  = "PROJECT_ID"
          value = local.project_id
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].spec[0].service_account_name,
      metadata[0].annotations["run.googleapis.com/operation-id"],
      metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"]
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}