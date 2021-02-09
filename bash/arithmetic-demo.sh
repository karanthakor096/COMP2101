#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

firstnum=5
secondnum=2
sum=$((firstnum + secondnum))
dividend=$((firstnum / secondnum))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")

cat <<EOF
$firstnum plus $secondnum is $sum
$firstnum divided by $secondnum is $dividend
  - More precisely, it is $fpdividend
EOF
echo "New code"
prompt="Enter 3 numbers "
read -p "$prompt" number1 number2 number3
echo "user entered these three numbers:- $number1 ,$number2, $number3"
sum=$((number1 + number2 + number3))
echo "Sum of three numbers:- $sum"
product=`expr $number1 \* $number2 \* $number3`
echo Product=$product
