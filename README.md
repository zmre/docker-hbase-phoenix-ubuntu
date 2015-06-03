# Docker Containers for HBase + Apache Phoenix on Ubuntu

There are a number of options for building up HBase and Phoenix including OS (Ubuntu vs. CentOS in my case), Java version (openjdk or oracle, 6 or 7 or 8), Hadoop source (TAR files vs. packages from Hortonworks or Cloudera), and hadoop versions.  I've experimented with most of these now and my biggest remaining issue is naming.

This repo contains my efforts at building on top of Ubuntu using the [phusion base image](https://github.com/phusion/baseimage-docker/) as a starting point.

Versions are managed via branches and you must select a branch in order to build.  Unfortunately, there are combinations of versions from Cloudera to Hadoop to Java that come into play here.  I've tried to use explicit naming to call out the choices, but the result is long image and tag names.  Sorry.  For the branches, I've stuck to the HBase version and jdk/jre choice as the branch name.

You won't see any docker files until you choose a branch.
