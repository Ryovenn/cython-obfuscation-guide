# Python Cython Obfuscation Guide

A simple guide for using **Cython** to distribute Python code as native modules (`.so` / `.pyd`), making it more difficult to analyze compared to regular `.py` files.

> ⚠️ **Important Note**
>
> Cython is **not a perfect protection mechanism** and **not encryption**. Compiled code can still be analyzed using reverse engineering techniques. Cython only increases the difficulty of analysis compared to plain Python source code.

---

## What is Cython?

Cython is a superset of Python that can be translated into C code and compiled into native extension modules.

Workflow:

```text
script.pyx
    ↓
Cython
    ↓
script.c
    ↓
C Compiler
    ↓
script.so / script.pyd
    ↓
import script
```

This allows applications to distribute compiled binary modules instead of plain Python source files.

---

## Project Structure

```text
project/
├── main.py
├── script.pyx
├── setup.py
└── README.md
```

---

## Installation

### Windows / Linux

```bash
pip install cython setuptools
```

### Termux (Android)

```bash
pkg update
pkg install clang python
pip install cython setuptools
```

---

## Example Source Code

### script.pyx

```python
class Hello:
    def print_hello(self):
        print("""
  Source Obfuscated with Cython
       Example Project

""")

def run():
    import os

    os.system('cls' if os.name == 'nt' else 'clear')

    obj = Hello()
    obj.print_hello()
```

---

## Build Configuration

### setup.py

```python
from setuptools import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize(
        "script.pyx",
        compiler_directives={
            "language_level": "3"
        }
    )
)
```

---

## Building the Module

Run the following command:

```bash
python setup.py build_ext --inplace
```

After a successful build, a compiled binary module will be generated.

Examples:

**Linux**

```text
script.cpython-313-x86_64-linux-gnu.so
```

**Termux (Android)**

```text
script.cpython-313-aarch64-linux-android.so
```

**Windows**

```text
script.cp313-win_amd64.pyd
```

---

## Running the Compiled Module

### main.py

```python
import script

script.run()
```

Execute:

```bash
python main.py
```

---

## How `import script` Works

When Python executes:

```python
import script
```

it searches for a matching module.

If a compiled extension module such as:

```text
script.cpython-313-aarch64-linux-android.so
```

or:

```text
script.cp313-win_amd64.pyd
```

is found, Python loads it as the `script` module.

Calling:

```python
script.run()
```

executes the compiled function exported by the extension module.

---

## Distribution

Files that can be distributed:

```text
main.py
script.so / script.pyd
README.md
LICENSE
```

Files that should not be distributed:

```text
script.pyx
script.c
setup.py
build/
```

These files may reveal implementation details of the original source code.

---

## Security Considerations

Cython increases the difficulty of analysis but does **not** provide complete protection.

| Method       | Reverse Engineering Difficulty |
| ------------ | ------------------------------ |
| Python (.py) | Low                            |
| Marshal      | Low                            |
| PyInstaller  | Medium                         |
| Cython       | Higher                         |
| Native C/C++ | High                           |

---

## Use Cases

Suitable for:

* Distributing Python applications without exposing plain source code
* Preventing casual inspection of application logic
* Improving performance in selected components
* Building reusable native extension modules

Not suitable for:

* Protecting highly sensitive secrets
* Relying on Cython as the only security mechanism

---

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for more information.

---

## Contributing

Pull requests, issues, and suggestions are welcome to improve this guide and make it more accessible for beginners.
