CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone -q $1 student-submission
echo 'Finished cloning'

# Uncomment code below if you want the script to work for nested ListExamples.java
#
# hash=$(find -type f -name "ListExamples.java")
# cp $hash student-submission/ListExamples.java
# cd student-submission

if test -f "ListExamples.java"; then 
    echo "File Exists"
else
    echo "File Does Not Exist"
    exit
fi

if grep -q "class ListExamples" ListExamples.java
then
    echo "Class Exists"
else
    echo "Class Doesn't Exist"
    exit
fi

if grep -q "static List<String> filter(List<String> s, StringChecker sc)" ListExamples.java
then
    echo "filter method implemented with correct header"
else
    echo "filter method not written with correct method header"
fi

if grep -q "static List<String> merge(List<String> list1, List<String> list2)" ListExamples.java
then
    echo "merge method implemented with correct header"
else
    echo "merge method not written with correct method header"
fi

cp ../TestListExamples.java TestListExamples.java
javac -cp ".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar" *.java
if [ $? -ne 0 ]; then
    echo "Compilation Error"
    exit
fi
java -cp ".;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > text.txt

if grep -q "There was 1 failure" text.txt
then
    echo "Fail"
else
    echo "Pass"
fi