#!/bin/bash
echo "🥚 Starting Auto Egg & Nest Setup"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root"
    exit 1
fi

if [ ! -d "/var/www/pterodactyl" ]; then
    echo "❌ Pterodactyl panel not found!"
    exit 1
fi

cd /var/www/pterodactyl || exit 1

# Check Pterodactyl version
echo "🔍 Checking Pterodactyl version..."
PANEL_VERSION=$(php artisan p:info | grep -oP 'Version:\s*\K[\d\.]+' | head -1)
echo "📊 Panel Version: $PANEL_VERSION"

# Method 1: Direct database insertion for nest creation
echo "📁 Creating Nest 'Pemrograman'..."
NEST_NAME="Pemrograman"

# Check if nest already exists
NEST_EXISTS=$(mysql -e "SELECT id FROM panel.nests WHERE name = '$NEST_NAME';" 2>/dev/null | tail -1)

if [ -z "$NEST_EXISTS" ]; then
    echo "📝 Creating new nest in database..."
    
    # Get the next available ID
    NEXT_ID=$(mysql -e "SELECT IFNULL(MAX(id), 0) + 1 FROM panel.nests;" 2>/dev/null | tail -1)
    
    # Insert nest into database
    mysql -e "INSERT INTO panel.nests (id, uuid, name, description, author, created_at, updated_at) 
              VALUES ($NEXT_ID, UUID(), '$NEST_NAME', 'Nest untuk pemrograman egg', 'System', NOW(), NOW());" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Nest '$NEST_NAME' created successfully!"
        NEST_ID=$NEXT_ID
    else
        echo "⚠️  Could not create nest via database. Will attempt to continue with default nest..."
        # Try to get an existing nest ID
        NEST_ID=$(mysql -e "SELECT id FROM panel.nests LIMIT 1;" 2>/dev/null | tail -1)
    fi
else
    echo "✅ Nest '$NEST_NAME' already exists (ID: $NEST_EXISTS)"
    NEST_ID=$NEST_EXISTS
fi

echo "📦 Creating Eggs..."

# Create eggs in /tmp directory
cat > /tmp/nodejs.json << 'EOF'
{
    "_comment": "DO NOT EDIT: FILE GENERATED AUTOMATICALLY BY PTERODACTYL PANEL - PTERODACTYL.IO",
    "meta": {
        "version": "PTDL_v2",
        "update_url": null
    },
    "exported_at": "2025-11-13T13:35:54+07:00",
    "name": "NodeJS",
    "author": "Ikanm",
    "description": "Node.js Application Egg",
    "features": null,
    "docker_images": {
        "ghcr.io/parkervcp/yolks:nodejs_24": "Node.js 24",
        "ghcr.io/parkervcp/yolks:nodejs_23": "Node.js 23",
        "ghcr.io/parkervcp/yolks:nodejs_22": "Node.js 22",
        "ghcr.io/parkervcp/yolks:nodejs_21": "Node.js 21",
        "ghcr.io/parkervcp/yolks:nodejs_20": "Node.js 20",
        "ghcr.io/parkervcp/yolks:nodejs_19": "Node.js 19",
        "ghcr.io/parkervcp/yolks:nodejs_18": "Node.js 18",
        "ghcr.io/parkervcp/yolks:nodejs_17": "Node.js 17",
        "ghcr.io/parkervcp/yolks:nodejs_16": "Node.js 16",
        "ghcr.io/parkervcp/yolks:nodejs_15": "Node.js 15",
        "ghcr.io/parkervcp/yolks:nodejs_14": "Node.js 14"
    },
    "file_denylist": [],
    "startup": "if [[ -d .git ]] && [[ {{AUTO_UPDATE}} == \"1\" ]]; then git pull; fi; if [[ ! -z \${NODE_PACKAGES} ]]; then /usr/local/bin/npm install \${NODE_PACKAGES}; fi; if [ -f /home/container/package.json ]; then /usr/local/bin/npm install; fi; /usr/local/bin/\${CMD_RUN};",
    "config": {
        "files": "{}",
        "startup": {
            "done": "running"
        },
        "logs": "{}",
        "stop": "^C"
    },
    "scripts": {
        "installation": {
            "script": "#!/bin/bash\n# NodeJS App Installation Script\n#\n# Server Files: /mnt/server\napt update\napt install -y git curl jq file unzip make gcc g++ python python-dev libtool\n\nmkdir -p /mnt/server\ncd /mnt/server\n\nif [ \"\${USER_UPLOAD}\" == \"true\" ] || [ \"\${USER_UPLOAD}\" == \"1\" ]; then\n    echo -e \"assuming user knows what they are doing have a good day.\"\n    exit 0\nfi\n\nif [[ \${GIT_ADDRESS} != *.git ]]; then\n    GIT_ADDRESS=\${GIT_ADDRESS}.git\nfi\n\nif [ -z \"\${USERNAME}\" ] && [ -z \"\${ACCESS_TOKEN}\" ]; then\n    echo -e \"using anon api call\"\nelse\n    GIT_ADDRESS=\"https://\${USERNAME}:\${ACCESS_TOKEN}@\$(echo -e \${GIT_ADDRESS} | cut -d/ -f3-)\"\nfi\n\nif [ \"\$(ls -A /mnt/server)\" ]; then\n    echo -e \"/mnt/server directory is not empty.\"\n    if [ -d .git ]; then\n        echo -e \".git directory exists\"\n        if [ -f .git/config ]; then\n            echo -e \"loading info from git config\"\n            ORIGIN=\$(git config --get remote.origin.url)\n        else\n            echo -e \"files found with no git config\"\n            exit 10\n        fi\n    fi\n\n    if [ \"\${ORIGIN}\" == \"\${GIT_ADDRESS}\" ]; then\n        echo \"pulling latest from github\"\n        git pull\n    fi\nelse\n    echo -e \"/mnt/server is empty.\"\n    if [ -z \${BRANCH} ]; then\n        git clone \${GIT_ADDRESS} .\n    else\n        git clone --single-branch --branch \${BRANCH} \${GIT_ADDRESS} .\n    fi\nfi\n\nif [[ ! -z \${NODE_PACKAGES} ]]; then\n    /usr/local/bin/npm install \${NODE_PACKAGES}\nfi\n\nif [ -f /mnt/server/package.json ]; then\n    /usr/local/bin/npm install --production\nfi\n\necho -e \"install complete\"\nexit 0",
            "container": "node:18-buster-slim",
            "entrypoint": "bash"
        }
    },
    "variables": [
        {
            "name": "Git Repository",
            "description": "GitHub repository URL to clone",
            "env_variable": "GIT_ADDRESS",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Branch",
            "description": "Git branch to use",
            "env_variable": "BRANCH",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        },
        {
            "name": "Start Command",
            "description": "Command to start the application",
            "env_variable": "CMD_RUN",
            "default_value": "npm start",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        },
        {
            "name": "Node Packages",
            "description": "Additional npm packages to install",
            "env_variable": "NODE_PACKAGES",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
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
    "name": "Python",
    "author": "Ikanm",
    "description": "Python Application Egg",
    "features": null,
    "docker_images": {
        "ghcr.io/ptero-eggs/yolks:python_3.12": "Python 3.12",
        "ghcr.io/ptero-eggs/yolks:python_3.11": "Python 3.11",
        "ghcr.io/ptero-eggs/yolks:python_3.10": "Python 3.10",
        "ghcr.io/ptero-eggs/yolks:python_3.9": "Python 3.9",
        "ghcr.io/ptero-eggs/yolks:python_3.8": "Python 3.8"
    },
    "file_denylist": [],
    "startup": "if [[ -d .git ]] && [[ {{AUTO_UPDATE}} == \"1\" ]]; then git pull; fi; if [[ ! -z {{PY_PACKAGES}} ]]; then pip install {{PY_PACKAGES}}; fi; if [[ -f /home/container/\${REQUIREMENTS_FILE} ]]; then pip install -r \${REQUIREMENTS_FILE}; fi; python /home/container/{{PY_FILE}}",
    "config": {
        "files": "{}",
        "startup": {
            "done": "ready"
        },
        "logs": "{}",
        "stop": "^C"
    },
    "scripts": {
        "installation": {
            "script": "#!/bin/bash\n# Python App Installation Script\n#\n# Server Files: /mnt/server\napt update\napt install -y git curl python3 python3-pip python3-venv\n\nmkdir -p /mnt/server\ncd /mnt/server\n\nif [ \"\${USER_UPLOAD}\" == \"true\" ] || [ \"\${USER_UPLOAD}\" == \"1\" ]; then\n    echo -e \"User uploaded files detected.\"\n    exit 0\nfi\n\nif [[ \${GIT_ADDRESS} != *.git ]]; then\n    GIT_ADDRESS=\${GIT_ADDRESS}.git\nfi\n\nif [ -z \"\${USERNAME}\" ] && [ -z \"\${ACCESS_TOKEN}\" ]; then\n    echo -e \"Using anonymous git clone\"\nelse\n    GIT_ADDRESS=\"https://\${USERNAME}:\${ACCESS_TOKEN}@\$(echo -e \${GIT_ADDRESS} | cut -d/ -f3-)\"\nfi\n\nif [ \"\$(ls -A /mnt/server)\" ]; then\n    echo -e \"/mnt/server directory is not empty.\"\n    if [ -d .git ]; then\n        if [ -f .git/config ]; then\n            ORIGIN=\$(git config --get remote.origin.url)\n            if [ \"\${ORIGIN}\" == \"\${GIT_ADDRESS}\" ]; then\n                echo \"Pulling latest changes\"\n                git pull\n            fi\n        fi\n    fi\nelse\n    echo -e \"Cloning repository\"\n    if [ -z \${BRANCH} ]; then\n        git clone \${GIT_ADDRESS} .\n    else\n        git clone --single-branch --branch \${BRANCH} \${GIT_ADDRESS} .\n    fi\nfi\n\nif [[ ! -z \${PY_PACKAGES} ]]; then\n    pip3 install \${PY_PACKAGES}\nfi\n\nif [ -f /mnt/server/requirements.txt ]; then\n    pip3 install -r requirements.txt\nfi\n\necho -e \"Installation complete\"\nexit 0",
            "container": "python:3.11-slim",
            "entrypoint": "bash"
        }
    },
    "variables": [
        {
            "name": "Python File",
            "description": "Main Python file to run",
            "env_variable": "PY_FILE",
            "default_value": "main.py",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        },
        {
            "name": "Requirements File",
            "description": "Python requirements file",
            "env_variable": "REQUIREMENTS_FILE",
            "default_value": "requirements.txt",
            "user_viewable": true,
            "user_editable": true,
            "rules": "required|string",
            "field_type": "text"
        },
        {
            "name": "Git Repository",
            "description": "Git repository URL",
            "env_variable": "GIT_ADDRESS",
            "default_value": "",
            "user_viewable": true,
            "user_editable": true,
            "rules": "nullable|string",
            "field_type": "text"
        }
    ]
}
EOF

# Import eggs
echo "📥 Importing NodeJS egg..."
php artisan p:egg:import /tmp/nodejs.json --force

echo "📥 Importing Python egg..."
php artisan p:egg:import /tmp/python.json --force

# Cleanup
rm -f /tmp/nodejs.json /tmp/python.json

# Clear cache
echo "🧹 Clearing cache..."
php artisan cache:clear
php artisan view:clear

echo "✅ Setup Completed!"
echo ""
echo "📋 Summary:"
echo "   • Nest: '$NEST_NAME' (ID: $NEST_ID)"
echo "   • Eggs: NodeJS and Python"
echo ""
echo "⚠️  Note: If eggs don't appear in the panel, you may need to:"
echo "   1. Check the nest ID in database: SELECT * FROM panel.nests;"
echo "   2. Manually assign eggs to the nest via panel UI"
echo "   3. Run: php artisan p:egg:list to see imported eggs"
