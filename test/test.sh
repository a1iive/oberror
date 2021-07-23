ob_error_dir=".."
test_file="./ob_error_test.test"
test_result_file="./ob_error_test.result"
result_file="./test.result"

rm -f $result_file

while read line
do
 #echo $line
 eval $line >> $result_file
done < $test_file

if cmp -s $result_file $test_result_file
then
    echo "test finish. success."
else
    echo "test finish. failed."
fi
