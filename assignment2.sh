#!/bin/bash

result=$(echo "3.2 + 2.7" |bc)
echo "result of addition: $result"

result=$(echo "3.2 - 2.0" |bc)
echo "result of subtraction: $result"

result=$(echo "2.5 * 3.0" |bc)
echo "result of multiplication: $result"

result=$(echo "8.0 / 2.5" |bc)
echo "result of division: $result"

result=$(echo "10.7 % 3.2" |bc)
echo "result of module: $result"
