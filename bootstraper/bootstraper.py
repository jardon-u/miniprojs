#! /usr/bin/env python

## import
#----------

#from __future__ import with_statement
import os
import shutil
from optparse import OptionParser


## Option parser
#----------------

parser = OptionParser(usage="%prog [options] project_name",
                      version="0.1")

# FIXME : default should be environment variable $USER
parser.add_option("-u", "--user", dest="login",
                  help="name/login of the project manager",
                  metavar="USER")

parser.add_option("-l", "--lang", dest="lang", default="cxx",
                  help="programming language",
                  metavar="LANG")

parser.add_option("-q", "--quiet",
                  action="store_false", dest="verbose", default=True,
                  help="quiet mode")

(opt, arg) = parser.parse_args()

if len(arg) != 1:
    parser.error("Wrong number of argument")

project = arg[0]
bsdir = "/home/ugo/dev/bootstraper/" + opt.lang + "/"

## main
#-------

dirpath = opt.login + "-" + project + "/"
os.mkdir(dirpath,0755)

if opt.lang == "cxx":
    os.chdir(dirpath)

    # + dirs
    os.mkdir("src", 0755)
    os.mkdir("build", 0755)
    os.mkdir("check", 0755)

    # + configure
    shutil.copyfile(bsdir+"configure","./configure")
    os.chmod("./configure",0755)

    # + Makefile
    with open(bsdir+"Makefile") as f:
        Makefile = f.read()
    Makefile = Makefile.replace("<<<PROJECT>>>", project)
    Makefile = Makefile.replace("<<<LOGIN>>>", opt.login)
    Makefile = Makefile.replace("<<<MAIN>>>", project+".cc")
    with open("./Makefile","w") as f:
        f.write(Makefile)

    # + main
    shutil.copyfile(bsdir+"main.cc","src/"+project+".cc")


