#!/bin/sh
for i in _*; do diff $i ~/${i/_/.}; done
