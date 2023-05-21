#!/bin/bash
find / -type f -executable -exec grep -Rl "/bin/bash" {} \; 2> /dev/null
