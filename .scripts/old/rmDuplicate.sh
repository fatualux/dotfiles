#!/bin/sh

WORKDIR=$HOME/.virtualenv/rmDuplicate/

cd $(pwd)

Launch() {
    source $WORKDIR/bin/activate
    python $WORKDIR/main.py
}

Launch
