############## Logstash Base #########

input {
	beats {
		port => 5044
	}
}

output {
    elasticsearch {
        hosts => "elasticsearch:9200"
        index => "lesson-04-base-%{+YYYY.MM.dd}"
    }
}


#### logstash IF ELSE ####
input {
	beats {
		port => 5044
	}
}

output {
	if [labels][filebeat] == "log-docker"{
		elasticsearch {
			hosts => "elasticsearch:9200"
			index => "lesson-04-%{+YYYY.MM.dd}"
		}
	}
	else {
		elasticsearch {
			hosts => "elasticsearch:9200"
			index => "other-%{+YYYY.MM.dd}"
		}
	}
}

############## filebeat multiline file #########################
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/error-java.log
  multiline.pattern: '^[0-9]{4}-[0-9]{2}-[0-9]{2}'
  multiline.negate: true
  multiline.match: after

output.logstash:
  hosts: ["logstash:5044"]

############## filebeat docker multiline #########################
filebeat.inputs:
- type: container
  paths: 
    - '/var/lib/docker/containers/*/*.log'
  multiline.pattern: '^=[A-Z]+|^$'
  multiline.negate: true
  multiline.match: after
  
processors:
- add_docker_metadata:
    host: "unix:///var/run/docker.sock"

- decode_json_fields:
    fields: ["message"]
    target: "json"
    overwrite_keys: true

output.logstash:
  hosts: ["logstash:5044"]

logging.json: true
logging.metrics.enabled: false

############## filebeat add labels #################
filebeat.inputs:
- type: container
  paths: 
    - '/var/lib/docker/containers/*/*.log'
  
processors:
- add_docker_metadata:
    host: "unix:///var/run/docker.sock"
- add_labels:
    labels:
      filebeat: log-docker # add labels log-docker

- decode_json_fields:
    fields: ["message"]
    target: "json"
    overwrite_keys: true

output.logstash:
  hosts: ["logstash:5044"]

logging.json: true
logging.metrics.enabled: false
