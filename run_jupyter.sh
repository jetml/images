#!/usr/bin/env bash

# turn on bash's job control
set -m

# Start the primary process and put it in the background
jupyter notebook --ip 0.0.0.0 --no-browser --allow-root &

/usr/bin/python3 -m pip install --upgrade pip

(pip --no-cache-dir install -r /notebooks/requirements.txt; /bin/bash /notebooks/start.sh)
(pip --no-cache-dir install -r /start/workspace-requirements-file.txt; pip --no-cache-dir install -r /start/instance-requirements-file.txt)
(/bin/bash /start/workspace-start-file.sh; /bin/bash /start/instance-start-file.sh)



if [ -z "$run_notebook_path" ]
then
      echo "\$run_notebook_path is empty"
else
      echo "\$run_notebook_path is NOT empty"
      dest_folder="/notebooks/workflow-runs"
      DIR="$(dirname "$run_notebook_path")" ; FILE="$(basename "$run_notebook_path")"
      echo "[${DIR}] [${FILE}]"
      mkdir -p "${dest_folder}${DIR}";
      current_timestamp=$(date +%s)
      output_path="${dest_folder}$run_notebook_path.${current_timestamp}.html" 
      (mkdir -p /notebooks/workflow-runs/notebooks && jupyter nbconvert --to html --execute $run_notebook_path --allow-errors --output ${output_path}) &
fi

# now we bring the primary process back into the foreground
# and leave it there
fg %1