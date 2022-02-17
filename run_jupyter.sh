#!/usr/bin/env bash
# Copyright 2015 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

(pip --no-cache-dir install -r /notebooks/requirements.txt; /bin/bash /notebooks/start.sh) &
(pip --no-cache-dir install -r /start/workspace-requirements-file.txt; pip --no-cache-dir install -r /start/instance-requirements-file.txt) &
(/bin/bash /start/workspace-start-file.sh; /bin/bash /start/instance-start-file.sh) &
   


if [ -z "$run_notebook_path" ]
then
      echo "\$run_notebook_path is empty"
else
      echo "\$run_notebook_path is NOT empty"
      dest_folder="/notebooks/workflow-runs"
      current_timestamp=$(date +%s)
      output_path="${dest_folder}$run_notebook_path.${current_timestamp}.html" 
      (mkdir -p /notebooks/workflow-runs/notebooks && jupyter nbconvert --to html --execute $run_notebook_path --allow-errors --output ${output_path}) &
fi

#jupyter notebook "$@"
jupyter notebook --ip 0.0.0.0 --no-browser --allow-root