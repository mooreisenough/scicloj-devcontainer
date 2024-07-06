#!/bin/bash -xe


###### SETUP JULIA LANG ##########
## TODO: check if jupyter gzip exits, if not then download it

## Setup Clojure Dependencies
clj -Sthreads 1 -P

## setup Julia before starting Jupyter: https://vpsie.com/knowledge-base/how-to-install-julia-on-ubuntu-22-04/
wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.0-linux-x86_64.tar.gz
 
#Once the compressed files containing the binaries are downloaded, use the tar command to extract them.

tar -xvzf julia-1.10.0-linux-x86_64.tar.gz
 
#Next, transfer all the extracted elements of the Julia Linux Binaries to the /opt directory:

sudo cp -r julia-1.10.0 /opt/

#To simplify usage, establish a symbolic link for it at /usr/local/bin/julia:

sudo ln -s /opt/julia-1.10.0/bin/julia /usr/local/bin/julia

#enable Julia in IPython
julia .devcontainer/iJulia.jl

##clean up Julia files
rm -rf julia-*/
rm *.tar.*

######## SET UP HY KERNEL #########
pip3 install git+https://github.com/ekaschalk/jedhy.git --user
pip3 install git+https://github.com/Calysto/calysto_hy.git --user

# DEFECT: From this file: /usr/local/python/current/lib/python3.11/site-packages/calysto_hy/kernel.py
# Need to Delete this line: from hy.version import __version__ as hy_version
# Need to replace this text: hy_version with hy.__version__
# If root user
# sed -i '/from hy.version import/d'  /usr/local/python/current/lib/python3.11/site-packages/calysto_hy/kernel.py
# sed -i 's/hy_version/hy.__version__/g' /usr/local/python/current/lib/python3.11/site-packages/calysto_hy/kernel.py
# if vscode user  /home/vscode/.local/lib/python3.10/site-packages
sed -i '/from hy.version import/d'  /home/vscode/.local/lib/python3.10/site-packages/calysto_hy/kernel.py
sed -i 's/hy_version/hy.__version__/g' /home/vscode/.local/lib/python3.10/site-packages/calysto_hy/kernel.py

## add Hy to Jupyter Notebooks
python3 -m calysto_hy install --user

## set up poetry 
rm poetry.lock
mkdir -p .venv && poetry install

### TODO Clean up unnecessary installation Files

## Start up Jupyter Lab
jupyter lab --NotebookApp.token='abcde54321' --no-browser --allow-root --debug --NotebookApp.iopub_msg_rate_limit=1000000.0 --NotebookApp.iopub_data_rate_limit=100000000.0 & 
