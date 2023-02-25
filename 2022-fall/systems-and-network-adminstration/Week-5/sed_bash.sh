#!/bin/bash

strip-tags ()
{
  sed -e 's/<[^>]*.//g' -
}
curl https://example.com/ --silent | strip-tags
