TOKEN="5596884767:AAHwneD-u5wTKjJncM3NiX_pv69_gEpCGGU" 
ID="-888913730"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$ID -d text="Hello thangnv"