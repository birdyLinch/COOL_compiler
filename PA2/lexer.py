# example run: python runmips.py stack.s

import inspect, os, sys, shlex, platform
import subprocess

def executePass(cmd, windows, i, o):
	cmdList = shlex.split(cmd)
	return subprocess.Popen(cmdList, shell=windows, stdin=i,stdout=o)

if platform.system() == "Windows":
	windows=True
else:
	windows=False

arglen = len(sys.argv)
arg_str = ' '.join(sys.argv[1:arglen])

script_file = inspect.getfile(inspect.currentframe())
script_location = os.path.dirname(os.path.abspath(script_file)).replace("\\","/")

classpath = script_location + "/coolc.jar"
opt = "-Djava.awt.headless=true"

cmd = "java %s -cp \"%s\" Lexer %s" % (opt, classpath, arg_str)
print cmd
p = executePass(cmd, windows, None, None)
p.wait()
