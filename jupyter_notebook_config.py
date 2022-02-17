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
import os
from IPython.lib import passwd

c = c  # pylint:disable=undefined-variable
c.NotebookApp.ip = '*'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
#c.NotebookApp.open_browser = False
c.NotebookApp.notebook_dir = '/notebooks'
c.NotebookApp.quit_button = False
c.NotebookApp.allow_origin = '*'
c.NotebookApp.tornado_settings = {'headers': {'X-Frame-Options': 'ALLOW-FROM http://localhost:8080','Content-Security-Policy': "frame-ancestors 'self' *"}}
c.NotebookApp.webbrowser_open_new = 0
c.NotebookApp.terminado_settings = { 'shell_command': ['/bin/bash'] }

#c.MappingKernelManager.cull_idle_timeout = 60
#c.NotebookApp.shutdown_no_activity_timeout = 70

# sets a password if PASSWORD is set in the environment
if 'TOKEN' in os.environ:
  token = os.environ['TOKEN']
  if token:
    c.NotebookApp.token = token
  del os.environ['TOKEN']


