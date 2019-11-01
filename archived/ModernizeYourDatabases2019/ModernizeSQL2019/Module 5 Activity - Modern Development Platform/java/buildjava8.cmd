rmdir /s /q c:\java\pkg
mkdir c:\java\pkg
"C:\Program Files\Java\jdk1.8.0_181\bin\javac" Ngram.java InputRow.java OutputRow.java
copy *.class c:\java\pkg