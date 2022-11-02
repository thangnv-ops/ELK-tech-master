# filebeat drop event
        - drop_event.when:
          or:
          - equals:
              kubernetes.namespace: "kube-system"
          - equals:
              kubernetes.namespace: "calico-system"

#filebeat drop fields

# logstash cắt logstash
filter {
    grok {
		match => { "message" => "%{IPORHOST:clientip}%{SPACE}%{USER:ident}%{SPACE}%{USER:auth}%{SPACE}(\[)%{HTTPDATE:timestamp}(\])%{SPACE}(\")%{WORD:verb}%{SPACE}%{NOTSPACE:request}%{DATA:httpversion}(\")%{SPACE}%{NUMBER:response}%{SPACE}%{NUMBER:bytes}%{GREEDYDATA:data}" }
    }
}

