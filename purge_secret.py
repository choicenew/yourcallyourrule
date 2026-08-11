import os

target_file = os.path.join("android", "app", "build.gradle")
if os.path.exists(target_file):
    with open(target_file, "rb") as f:
        content = f.read()
    if b"slroeeb@gmail.com" in content:
        content = content.replace(b"slroeeb@gmail.com", b"REDACTED_EMAIL")
        with open(target_file, "wb") as f:
            f.write(content)
