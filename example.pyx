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
