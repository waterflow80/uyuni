#!/bin/sh

export CONTAINER_CONNECTION=server

echo "Copying billingdataservice to server:/usr/lib/python"
mgrctl cp ./billingdataservice server:/usr/lib/python
echo "Copying linting to server:/usr/lib/python"
mgrctl cp ./linting server:/usr/lib/python
echo "Copying lzreposync to server:/usr/lib/python"
mgrctl cp ./lzreposync server:/usr/lib/python
echo "Copying rhn to server:/usr/lib/python"
mgrctl cp ./rhn server:/usr/lib/python
echo "Copying spacewalk to server:/usr/lib/python"
mgrctl cp ./spacewalk server:/usr/lib/python
echo "Copying uyuni to server:/usr/lib/python"
mgrctl cp ./uyuni server:/usr/lib/python
