import os
import subprocess


def run_wrapper_command(exec_name, args):
    qcc_env = os.environ.copy()
    if "QNX_HOST" in qcc_env:
        args.insert(0, "{}/usr/bin/{}".format(qcc_env["QNX_HOST"], exec_name))
    else:
        print("QNX_HOST is not set")
        exit(1)
    qcc_cwd = os.getcwd()

    popen = subprocess.Popen(args, env=qcc_env, cwd=qcc_cwd, stdout=subprocess.PIPE)

    return_code = popen.wait()

    if return_code != 0:
        print("{} failed".format(exec_name))
    exit(return_code)
