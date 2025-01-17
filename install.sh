#!/bin/bash

#
# Copyright 2021 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

echo 'Enabling necessary APIs'

project=$(grep -o '\"project_id\": \"[^\"]*' terraform.tfvars.json | grep -o '[^\"]*$')
gcloud services enable "compute.googleapis.com" --project=$project

export APIS="googleapis.com www.googleapis.com bigquery.googleapis.com bigquerystorage.googleapis.com iam.googleapis.com iamcredentials.googleapis.com pubsub.googleapis.com dataflow.googleapis.com storage.googleapis.com compute.googleapis.com run.googleapis.com apigateway.googleapis.com servicemanagement.googleapis.com servicecontrol.googleapis.com iap.googleapis.com sql-component.googleapis.com cloudapis.googleapis.com sqladmin.googleapis.com secretmanager.googleapis.com cloudresourcemanager.googleapis.com"
for i in $APIS
do
  echo "199.36.153.10 $i" >> /etc/hosts
done