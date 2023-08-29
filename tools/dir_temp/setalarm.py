#! /usr/bin/env  python3
import signal, os, subprocess

def sig_handler(signum, frame):
    global pid, killed
    killed = True
    print("---------------")
    print(signum)
    print(frame)
    print("---------------")
    os.kill(pid, signal.SIGTERM)
    os.kill(pid, signal.SIGKILL)

def func1():
    a = 0
    for i in range(0, 100000):
        a += i

if __name__ == "__main__":
    signal.signal(signal.SIGALRM, sig_handler) 
    signal.alarm(1)
    with open(os.devnull, "w") as devnull:
        proc = subprocess.Popen(['find', '/', '-name', 'qemu2'], stdout = devnull, stderr = devnull)
    global pid, killed
    pid = proc.pid
    killed = False
    proc.wait()
    if not killed:
        signal.alarm(0)
    else:
        print("Time out")
    print(proc.returncode)
