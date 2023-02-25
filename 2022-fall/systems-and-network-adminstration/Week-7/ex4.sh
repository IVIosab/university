#!/bin/bash
kill $(ps aux | grep -E "fun[0-9]+process" | awk '{print $2}')
