import os

def replace_in_file(filepath):
    try:
        with open(filepath, "rb") as f:
            content = f.read()
        if b"slroeeb@gmail.com" in content:
            content = content.replace(b"slroeeb@gmail.com", b"REDACTED_SECRET")
            with open(filepath, "wb") as f:
                f.write(content)
    except Exception:
        pass

for root, dirs, files in os.walk("."):
    if ".git" in root:
        continue
    for file in files:
        replace_in_file(os.path.join(root, file))
