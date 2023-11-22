
# Fetch the text from the URL
text=$(curl -s "https://paste.rs/wSrfO.raw")

# Replace the value in devcontainer.json with the fetched text
sed -i.bak "s|\"github-enterprise.uri\": \"\"|\"github-enterprise.uri\": \"$text\"|g" devcontainer.json

# Remove the backup file
rm devcontainer.json.bak

