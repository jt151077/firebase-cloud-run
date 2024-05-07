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


import base64
import os
import random
import functions_framework
import json
import math

from flask import Flask, request
from google.cloud import firestore

PROJECT_ID = os.getenv("PROJECT_ID", "")
client = firestore.Client(project=PROJECT_ID)

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    collections = client.collection("incrementer").document("status")
    doc = collections.get()
    if doc.exists:
        return (doc.to_dict(), 200)
    else:
        return ("no docs", 200)


# [START eventarc_pubsub_server]
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
# [END eventarc_pubsub_server]
