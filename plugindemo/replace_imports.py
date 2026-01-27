import os
import re

def replace_imports(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    
                    # 替换导入路径
                    new_content = re.sub(r'package:yourcallyourrule', r'package:plugindemo', content)
                    
                    if new_content != content:
                        with open(file_path, 'w', encoding='utf-8') as f:
                            f.write(new_content)
                        print(f'Replaced in {file_path}')
                except Exception as e:
                    print(f'Error processing {file_path}: {e}')

if __name__ == '__main__':
    lib_dir = r'c:\Users\Ngokel\Desktop\en\test\github\yourcallyourrulemixhistory\plugindemo\lib'
    replace_imports(lib_dir)
