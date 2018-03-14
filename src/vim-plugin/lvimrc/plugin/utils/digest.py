#!/usr/bin/env python

import base64
import hashlib
import hmac
import os
import sys

KEY_LEN = 32
KEY_FILE = os.path.expanduser("~/.vim/.lvimrc_key")
DIGEST_PREFIX = '" lvimrc-digest: '


def read_key(key_file=KEY_FILE):

    # if we don't have such file, generate one
    if not os.path.exists(key_file):
        fd = os.open(key_file, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0600)
        with os.fdopen(fd, "w") as fout:
            key = base64.b64encode(os.urandom(KEY_LEN))
            fout.write(key)

    with open(key_file, "r") as fin:
        key = base64.b64decode(fin.read().strip())
        assert len(key) == KEY_LEN
        return key


def read_rc(file):

    with open(file, "r") as fin:
        lines = fin.readlines()
    
    # extract digest from last line
    if len(lines) > 0 and lines[-1].startswith(DIGEST_PREFIX):
        digest = lines.pop()[len(DIGEST_PREFIX):].strip()
    else:
        digest = None

    return "".join(lines), digest


def calc_digest(key, data):
    return hmac.new(key, data, hashlib.sha1).hexdigest()


def cmd_verify_rc(file):

    content, orgi_digest = read_rc(file)
    if orgi_digest is None:
        sys.stderr.write("Missing digest.\n")
        sys.exit(-1)

    digest = calc_digest(read_key(), content)
    if (digest != orgi_digest):
        sys.stderr.write("Wrong digest: expect `{}' but `{}' get.\n".format(digest, orgi_digest))
        sys.exit(-1)


def cmd_update_rc(file):

    content, _ = read_rc(file)
    if content != "" and content[-1] != "\n":
        content += "\n"
    digest = calc_digest(read_key(), content)

    with open(file, "w") as fout:
        fout.write(content + DIGEST_PREFIX + digest)


if __name__ == "__main__":

    if len(sys.argv) != 3:
        sys.stderr.write("Usage: {} <cmd> <lvimrc_file>\n".format(sys.argv[0]))
        sys.exit(-1)

    cmd = sys.argv[1]
    file = sys.argv[2]

    if cmd == "verify":
        cmd_verify_rc(file)
    elif cmd == "update":
        cmd_update_rc(file)
    else:
        sys.stderr.write("Unknown cmd: {}".format(cmd))
