		http {
			format => "json"
			http_method => "post"
			url => "https://api.telegram.org:443/bot5573884598:AAGMvBN4QGwMXNuC_jzwA2_UB8bL0QTXyRY/sendMessage"
			mapping => {
				"chat_id" => "-898635285"
				"text" => "%{message}"
			}
		}