############## Lab1 : Cài đặt elasticsearch #################################
docker-compose up -d
docker exec -it techmaster-elasticsearch bash
bin/elasticsearch-setup-passwords auto

######## Logstash base #################################
input {
	beats {
		port => 5044
	}

	tcp {
		port => 50000
	}
  	heartbeat {
		interval => 5
		message  => 'Hello from Logstash 💓.'
  	}
}
output {
	elasticsearch {
		hosts => "elasticsearch:9200"
		user => "logstash"
		password => "o4aN6fy2pLroGZ"
		index => "lesson-05-%{+YYYY.MM.dd}"
	}
}


########### Cấu hình logstash #################################
input {
	beats {
		port => 5044
	}

	tcp {
		port => 50000
	}
  	heartbeat {
		interval => 5
		message  => 'Hello from Logstash 💓.'
  	}
}

output {
	if [agent][type] == "filebeat"{
		elasticsearch {
			hosts => "elasticsearch:9200"
			user => "logstash"
			password => "o4aN6fy2pLroGZ"
			index => "filebeat-05-%{+YYYY.MM.dd}"
		}
	}
	else {
		elasticsearch {
			hosts => "elasticsearch:9200"
			user => "logstash"
			password => "o4aN6fy2pLroGZ"
			index => "hello-%{+YYYY.MM.dd}"
		}
	}
}
