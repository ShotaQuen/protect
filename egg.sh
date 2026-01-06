#!/bin/bash
echo "🥚 Starting Auto Egg & Nest Setup"

if [ ! -d "/var/www/pterodactyl" ]; then
    echo "❌ Pterodactyl panel not found!"
    exit 1
fi

cd /var/www/pterodactyl
echo "📁 Creating Nest..."
NEST_NAME="Pemrograman"
php artisan p:nest:create --name="$NEST_NAME" --description="Nest untuk pemrograman egg"

echo "📦 Creating Egg..."
cat > /tmp/nodejs.json << 'EOF'
{
    "_comment": "DO NOT EDIT: FILE GENERATED AUTOMATICALLY BY PTERODACTYL PANEL - PTERODACTYL.IO",
    "meta": {
        "version": "PTDL_v2",
        "update_url": null
    },
    "exported_at": "2025-11-13T13:35:54+07:00",
    "name": "Nodejs",
    "author": "Ikann",
    "description": null,
    "features": null,
    "docker_images": {
        "ghcr.io\/parkervcp\/yolks:nodejs_24": "ghcr.io\/parkervcp\/yolks:nodejs_24",
        "ghcr.io\/parkervcp\/yolks:nodejs_23": "ghcr.io\/parkervcp\/yolks:nodejs_23",
        "ghcr.io\/parkervcp\/yolks:nodejs_22": "ghcr.io\/parkervcp\/yolks:nodejs_22",
        "ghcr.io\/parkervcp\/yolks:nodejs_21": "ghcr.io\/parkervcp\/yolks:nodejs_21",
        "ghcr.io\/parkervcp\/yolks:nodejs_20": "ghcr.io\/parkervcp\/yolks:nodejs_20",
        "ghcr.io\/parkervcp\/yolks:nodejs_19": "ghcr.io\/parkervcp\/yolks:nodejs_19",
        "ghcr.io\/parkervcp\/yolks:nodejs_18": "ghcr.io\/parkervcp\/yolks:nodejs_18",
        "ghcr.io\/parkervcp\/yolks:nodejs_17": "ghcr.io\/parkervcp\/yolks:nodejs_17",
        "ghcr.io\/parkervcp\/yolks:nodejs_16": "ghcr.io\/parkervcp\/yolks:nodejs_16",
        "ghcr.io\/parkervcp\/yolks:nodejs_15": "ghcr.io\/parkervcp\/yolks:nodejs_15",
        "ghcr.io\/parkervcp\/yolks:nodejs_14": "ghcr.io\/parkervcp\/yolks:nodejs_14",
        "ghcr.io\/parkervcp\/yolks:nodejs_13": "ghcr.io\/parkervcp\/yolks:nodejs_13",
        "ghcr.io\/parkervcp\/yolks:nodejs_12": "ghcr.io\/parkervcp\/yolks:nodejs_12",
        "ghcr.io\/parkervcp\/yolks:nodejs_11": "ghcr.io\/parkervcp\/yolks:nodejs_11",
        "ghcr.io\/parkervcp\/yolks:nodejs_10": "ghcr.io\/parkervcp\/yolks:nodejs_10",
        "ghcr.io\/parkervcp\/yolks:nodejs_9": "ghcr.io\/parkervcp\/yolks:nodejs_9",
        "ghcr.io\/parkervcp\/yolks:nodejs_8": "ghcr.io\/parkervcp\/yolks:nodejs_8",
        "ghcr.io\/parkervcp\/yolks:nodejs_7": "ghcr.io\/parkervcp\/yolks:nodejs_7",
        "ghcr.io\/parkervcp\/yolks:nodejs_6": "ghcr.io\/parkervcp\/yolks:nodejs_6",
        "ghcr.io\/parkervcp\/yolks:nodejs_5": "ghcr.io\/parkervcp\/yolks:nodejs_5",
        "ghcr.io\/parkervcp\/yolks:nodejs_4": "ghcr.io\/parkervcp\/yolks:nodejs_4",
        "ghcr.io\/parkervcp\/yolks:nodejs_3": "ghcr.io\/parkervcp\/yolks:nodejs_3",
        "ghcr.io\/parkervcp\/yolks:nodejs_2": "ghcr.io\/parkervcp\/yolks:nodejs_2",
        "ghcr.io\/parkervcp\/yolks:nodejs_1": "ghcr.io\/parkervcp\/yolks:nodejs_1"
    },
    "file_denylist": [],
    "startup": "if [[ -d .git ]] && [[ {{AUTO_UPDATE}} == \"1\" ]]; then git pull; fi; if [[ ! -z ${NODE_PACKAGES} ]]; then \/usr\/local\/bin\/npm install ${NODE_PACKAGES}; fi; if [[ ! -z ${UNNODE_PACKAGES} ]]; then \/usr\/local\/bin\/npm uninstall ${UNNODE_PACKAGES}; fi; if [ -f \/home\/container\/package.json ]; then \/usr\/local\/bin\/npm install; fi;  if [[ ! -z ${CUSTOM_ENVIRONMENT_VARIABLES} ]]; then      vars=$(echo ${CUSTOM_ENVIRONMENT_VARIABLES} | tr \";\" \"\\n\");      for line in $vars;     do export $line;     done fi;  \/usr\/local\/bin\/${CMD_RUN};",
    "config": {
        "files": "{}",
        "startup": "{\r\n    \"done\": \"running\"\r\n}",
        "logs": "{}",
        "stop": "^^C"
    },
    "scripts": {
        "installation": {
            "script": "#!\/bin\/bash\r\n# NodeJS App Installation Script\r\n#\r\n# Server Files: \/mnt\/server\r\napt update\r\napt install -y git curl jq file unzip make gcc g++ python python-dev libtool\r\n\r\nmkdir -p \/mnt\/server\r\ncd \/mnt\/server\r\n\r\nif [ \"${USER_UPLOAD}\" == \"true\" ] || [ \"${USER_UPLOAD}\" == \"1\" ]; then\r\n    echo -e \"assuming user knows what they are doing have a good day.\"\r\n    exit 0\r\nfi\r\n\r\n## add git ending if it's not on the address\r\nif [[ ${GIT_ADDRESS} != *.git ]]; then\r\n    GIT_ADDRESS=${GIT_ADDRESS}.git\r\nfi\r\n\r\nif [ -z \"${USERNAME}\" ] && [ -z \"${ACCESS_TOKEN}\" ]; then\r\n    echo -e \"using anon api call\"\r\nelse\r\n    GIT_ADDRESS=\"https:\/\/${USERNAME}:${ACCESS_TOKEN}@$(echo -e ${GIT_ADDRESS} | cut -d\/ -f3-)\"\r\nfi\r\n\r\n## pull git js repo\r\nif [ \"$(ls -A \/mnt\/server)\" ]; then\r\n    echo -e \"\/mnt\/server directory is not empty.\"\r\n    if [ -d .git ]; then\r\n        echo -e \".git directory exists\"\r\n        if [ -f .git\/config ]; then\r\n            echo -e \"loading info from git config\"\r\n            ORIGIN=$(git config --get remote.origin.url)\r\n        else\r\n            echo -e \"files found with no git config\"\r\n            echo -e \"closing out without touching things to not break anything\"\r\n            exit 10\r\n        fi\r\n    fi\r\n\r\n    if [ \"${ORIGIN}\" == \"${GIT_ADDRESS}\" ]; then\r\n        echo \"pulling latest from github\"\r\n        git pull\r\n    fi\r\nelse\r\n    echo -e \"\/mnt\/server is empty.\\ncloning files into repo\"\r\n    if [ -z ${BRANCH} ]; then\r\n        echo -e \"cloning default branch\"\r\n        git clone ${GIT_ADDRESS} .\r\n    else\r\n        echo -e \"cloning ${BRANCH}'\"\r\n        git clone --single-branch --branch ${BRANCH} ${GIT_ADDRESS} .\r\n    fi\r\n\r\nfi\r\n\r\necho \"Installing nodejs packages\"\r\nif [[ ! -z ${NODE_PACKAGES} ]]; then\r\n    \/usr\/local\/bin\/npm install ${NODE_PACKAGES}\r\nfi\r\n\r\nif [ -f \/mnt\/server\/package.json ]; then\r\n    \/usr\/local\/bin\/npm install --production\r\nfi\r\n\r\necho -e \"install complete\"\r\nexit 0",
            "container": "node:14-buster-slim",
            "entrypoint": "bash"
        }
    },
    "variables": [
        {
            "name": "Git Repo Address",
            "description": "GitHub Repo to clone\r\n\r\nI.E. https:\/\/github.com\/user_name\/repo_name",
            "env_variable": "GIT_ADDRESS",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Install Branch",
            "description": "The branch to install.",
            "env_variable": "BRANCH",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Git Username",
            "description": "Username to auth with git.",
            "env_variable": "USERNAME",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Git Access Token",
            "description": "Password to use with git.\r\n\r\nIt's best practice to use a Personal Access Token.\r\nhttps:\/\/github.com\/settings\/tokens\r\nhttps:\/\/gitlab.com\/-\/profile\/personal_access_tokens",
            "env_variable": "ACCESS_TOKEN",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Command Run",
            "description": "The command to start the bot",
            "env_variable": "CMD_RUN",
            "default_value": "npm start",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        }
    ]
}
EOF

cat > /tmp/python.json << 'EOF'
{
    "_comment": "DO NOT EDIT: FILE GENERATED AUTOMATICALLY BY PTERODACTYL PANEL - PTERODACTYL.IO",
    "meta": {
        "version": "PTDL_v2",
        "update_url": null
    },
    "exported_at": "2025-12-02T07:04:42+07:00",
    "name": "python",
    "author": "Ikanm",
    "description": "A Generic Python Egg for Pterodactyl",
    "features": null,
    "docker_images": {
        "Python 3.13": "ghcr.io\/ptero-eggs\/yolks:python_3.13",
        "Python 3.12": "ghcr.io\/ptero-eggs\/yolks:python_3.12",
        "Python 3.11": "ghcr.io\/ptero-eggs\/yolks:python_3.11",
        "Python 3.10": "ghcr.io\/ptero-eggs\/yolks:python_3.10",
        "Python 3.9": "ghcr.io\/ptero-eggs\/yolks:python_3.9",
        "Python 3.8": "ghcr.io\/ptero-eggs\/yolks:python_3.8",
        "Python 3.7": "ghcr.io\/ptero-eggs\/yolks:python_3.7",
        "Python 2.7": "ghcr.io\/ptero-eggs\/yolks:python_2.7"
    },
    "file_denylist": [],
    "startup": "if [[ -d .git ]] && [[ \"{{AUTO_UPDATE}}\" == \"1\" ]]; then git pull; fi; if [[ ! -z \"{{PY_PACKAGES}}\" ]]; then pip install -U --prefix .local {{PY_PACKAGES}}; fi; if [[ -f \/home\/container\/${REQUIREMENTS_FILE} ]]; then pip install -U --prefix .local -r ${REQUIREMENTS_FILE}; fi; \/usr\/local\/bin\/python \/home\/container\/{{PY_FILE}}",
    "config": {
        "files": "{}",
        "startup": "{\r\n    \"done\": \"gudel023\"\r\n}",
        "logs": "{}",
        "stop": "^C"
    },
    "scripts": {
        "installation": {
            "script": "#!\/bin\/bash\r\n# Python App Installation Script\r\n#\r\n# Server Files: \/mnt\/server\r\napt update\r\napt install -y git curl jq file unzip make gcc g++ libtool\r\n\r\nmkdir -p \/mnt\/server\r\ncd \/mnt\/server\r\n\r\nif [ \"${USER_UPLOAD}\" == \"true\" ] || [ \"${USER_UPLOAD}\" == \"1\" ]; then\r\n    echo -e \"assuming user knows what they are doing have a good day.\"\r\n    exit 0\r\nfi\r\n\r\n## add git ending if it's not on the address\r\nif [[ ${GIT_ADDRESS} != *.git ]]; then\r\n    GIT_ADDRESS=${GIT_ADDRESS}.git\r\nfi\r\n\r\nif [ -z \"${USERNAME}\" ] && [ -z \"${ACCESS_TOKEN}\" ]; then\r\n    echo -e \"using anon api call\"\r\nelse\r\n    GIT_ADDRESS=\"https:\/\/${USERNAME}:${ACCESS_TOKEN}@$(echo -e ${GIT_ADDRESS} | cut -d\/ -f3-)\"\r\nfi\r\n\r\n## pull git python repo\r\nif [ \"$(ls -A \/mnt\/server)\" ]; then\r\n    echo -e \"\/mnt\/server directory is not empty.\"\r\n    if [ -d .git ]; then\r\n        echo -e \".git directory exists\"\r\n        if [ -f .git\/config ]; then\r\n            echo -e \"loading info from git config\"\r\n            ORIGIN=$(git config --get remote.origin.url)\r\n        else\r\n            echo -e \"files found with no git config\"\r\n            echo -e \"closing out without touching things to not break anything\"\r\n            exit 10\r\n        fi\r\n    fi\r\n\r\n    if [ \"${ORIGIN}\" == \"${GIT_ADDRESS}\" ]; then\r\n        echo \"pulling latest from github\"\r\n        git pull\r\n    fi\r\nelse\r\n    echo -e \"\/mnt\/server is empty.\\ncloning files into repo\"\r\n    if [ -z ${BRANCH} ]; then\r\n        echo -e \"cloning default branch\"\r\n        git clone ${GIT_ADDRESS} .\r\n    else\r\n        echo -e \"cloning ${BRANCH}'\"\r\n        git clone --single-branch --branch ${BRANCH} ${GIT_ADDRESS} .\r\n    fi\r\n\r\nfi\r\n\r\nexport HOME=\/mnt\/server\r\n\r\necho \"Installing python requirements into folder\"\r\nif [[ ! -z ${PY_PACKAGES} ]]; then\r\n    pip install -U --prefix .local ${PY_PACKAGES}\r\nfi\r\n\r\nif [ -f \/mnt\/server\/requirements.txt ]; then\r\n    pip install -U --prefix .local -r ${REQUIREMENTS_FILE}\r\nfi\r\n\r\necho -e \"install complete\"\r\nexit 0",
            "container": "python:3.8-slim-bookworm",
            "entrypoint": "bash"
        }
    },
    "variables": [
        {
            "name": "Git Repo Address",
            "description": "Git repo to clone\r\n\r\nI.E. https:\/\/github.com\/parkervcp\/repo_name",
            "env_variable": "GIT_ADDRESS",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Git Branch",
            "description": "What branch to pull from github.\r\n\r\nDefault is blank to pull the repo default branch",
            "env_variable": "BRANCH",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "User Uploaded Files",
            "description": "Skip all the install stuff if you are letting a user upload files.\r\n\r\n0 = false (default)\r\n1 = true",
            "env_variable": "USER_UPLOAD",
            "default_value": "0",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|boolean",
            "field_type": "text"
        },
        {
            "name": "Auto Update",
            "description": "Pull the latest files on startup when using a GitHub repo.",
            "env_variable": "AUTO_UPDATE",
            "default_value": "0",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|boolean",
            "field_type": "text"
        },
        {
            "name": "App py file",
            "description": "The file that starts the App.",
            "env_variable": "PY_FILE",
            "default_value": "app.py",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        },
        {
            "name": "Additional Python packages",
            "description": "Install additional python packages.\r\n\r\nUse spaces to separate",
            "env_variable": "PY_PACKAGES",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Git Username",
            "description": "Username to auth with git.",
            "env_variable": "USERNAME",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Git Access Token",
            "description": "Password to use with git.\r\n\r\nIt's best practice to use a Personal Access Token.\r\nhttps:\/\/github.com\/settings\/tokens\r\nhttps:\/\/gitlab.com\/-\/profile\/personal_access_tokens",
            "env_variable": "ACCESS_TOKEN",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Requirements file",
            "description": "if there are other requirements files to choose from.",
            "env_variable": "REQUIREMENTS_FILE",
            "default_value": "requirements.txt",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        }
    ]
}
EOF

php artisan p:egg:import /tmp/nodejs.json
rm -f /tmp/nodejs.json

php artisan p:egg:import/tmp/python.json
rm -f /tmp/python.json

echo "✅ Setup Completed!"
