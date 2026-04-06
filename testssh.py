import subprocess
import sys 

HOST="hash@192.168.1.27"
COMMAND="pwd"
password='0P@ssw0rd'
#ret = subprocess.call(["ssh", "hash@192.168.1.27", "echo hello"]);
#print(ret)
ssh = subprocess.Popen(["ssh", "%s" % HOST, COMMAND], shell=False, stdout=subprocess.PIPE, stdin = subprocess.PIPE, stderr=subprocess.PIPE)
ssh.stdin.write(password.encode())
ssh.stdin.flush()
result = ssh.stdout.readlines()
if result == []: 
    error = ssh.stderr.readlines()
    print >>sys.stderr, "ERROR: %s" % error
else:
    print(result)

ssh.stdin.close()
ssh.stdout.close()
ssh.stderr.close()