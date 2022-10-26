TOKEN="5573884598:AAGMvBN4QGwMXNuC_jzwA2_UB8bL0QTXyRY" 
ID="-898635285"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$ID -d text="Hello World"